const TodoList = require('../models/todoModel');

module.exports = {
  get: (req, res) => {
    TodoList.find({ idUser: req.data_user.id }, (err, todo) => {
      if (err) {
        res.json({
          result: 'err',
          message: err.message,
        });
      }
      else if (todo) {
        res.json({
          result: 'ok',
          data: todo
        });
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  },
  store: (req, res) => {
    let todo = new TodoList({
      title: req.body.title,
      idUser: req.data_user.id
    });
    todo.save((err, todo) => {
      let message = 'Error';
      if (err) {
        if (err.code == 11000) message = 'Title has been used!';
        res.json({
          result: 'err',
          message: message,
        });
      }
      else if (todo) {
        res.json({
          result: 'ok',
          data: todo
        });
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  },
  detail: (req, res) => {
    TodoList.findById({ _id: req.params.todoId }, (err, todo) => {
      if (err) {
        res.json({
          result: 'err',
          message: err.message
        });
      }
      else if (todo && todo.idUser == req.data_user.id) {
        res.json({
          result: 'ok',
          data: todo
        });
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  },
  update: (req, res) => {
    TodoList.findOneAndUpdate({ _id: req.params.todoId, idUser: req.data_user.id }, req.body, { new: true }, (err, todo) => {
      if (err) {
        res.json({
          result: 'err',
          message: err.message
        });
      }
      else if (todo) {
        res.json({
          result: 'ok',
          data: todo
        });
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  },
  delete: (req, res) => {
    TodoList.findById(req.params.todoId, (err, todo) => {
      if (err) {
        res.json({
          result: 'err',
          message: err.message
        });
      }
      else if (todo) {
        if (todo.idUser == req.data_user.id) {
          TodoList.remove({ _id: req.params.todoId }, (err, todo) => {
            if (err) {
              res.json({
                result: 'err',
                message: err.message
              });
            }
            if (todo) {
              res.json({
                result: 'ok',
                data: 'Item todo deleted'
              });
            }
          });
        }
      }
      else {
        res.json({
          result: 'err',
          message: 'Error'
        })
      }
    });
  },
}
