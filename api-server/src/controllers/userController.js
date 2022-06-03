const Users = require('../models/userModel');
const auth = require('../services/auth');
const md5 = require("crypto-js/md5");

module.exports = {
  login: (req, res) => {
    Users.findOne(
      {
        email: req.body.email,
      },
      (err, user) => {
        if (err) {
          res.json({
            result: 'err',
            message: err.message
          });
        }
        else if (user) {
          if (user.password == md5(req.body.password)) {
            let token = auth.siginToken({
              id: user._id,
              name: user.name,
              email: user.email
            });
            res.json({
              result: 'ok',
              token: token
            });
          }
          else {
            res.json({
              result: 'err',
              message: 'Incorrect password'
            })
          }
        }
        else {
          res.json({
            resule: 'err',
            message: 'Error'
          })
        }
      }
    );
  },
  register: (req, res) => {
    let user = new Users({
      name: req.body.name,
      email: req.body.email,
      password: md5(req.body.password)
    });
    user.save((err, user) => {
      if (user) {
        res.json({
          result: 'ok',
          data: user
        });
      }
      else if (err) {
        let message = err.message;
        if (err.code == 11000) message = 'email has been used!'
        res.json({
          result: 'err',
          message: message
        });
      }
      else {
        res.json({
          resule: 'err',
          message: 'Error'
        })
      }
    });
  },
  changePassword: (req, res) => {
    Users.findById(req.data_user.id, (err, user) => {
      if (err) {
        res.json({
          result: 'err',
          message: 'Can\'t find account!'
        });
      }
      else if (user) {
        newPassword = md5(req.body.newPassword);
        if (user.password == md5(req.body.password)) {
          if (user.password == newPassword) {
            res.json({
              result: 'err',
              message: 'No change password!'
            });
          }
          else {
            user.password = newPassword;
            user.save((err, user) => {
              if (err) {
                res.json({
                  result: 'err',
                  message: err.message
                });
              }
              else if (user) {
                res.json({
                  result: 'ok',
                  message: 'Change password successfully'
                });
              }
              else {
                res.json({
                  result: 'err',
                  message: 'Error'
                })
              }
            });
          }
        }
        else {
          res.json({
            result: 'err',
            message: 'Incorrect password!'
          });
        }
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        });
      }
    });
  },
  getOne: (req, res) => {
    res.json({
      result: 'ok',
      data: req.data_user
    })
  },
  getAll: (req, res) => {
    Users.find({}, (err, users) => {
      if (err) {
        res.json({
          result: 'err',
          message: err.message
        });
      }
      else if (users) {
        res.json({
          result: 'ok',
          data: users
        });
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  }
}
