const { SECRET_KEY, TIME_OUT_TOKEN } = require('../config/index');
const validator = require('validator');
const jwt = require('jsonwebtoken');

function verifyToken(token) {
  if (token && validator.isJWT(token)) {
    return jwt.verify(token, SECRET_KEY, (err, decoded) => {
      if (decoded) {
        return decoded;
      }
      else if (err) {
        return undefined;
      }
    });
  }
  else return undefined
}

function siginToken(data) {
  let token = jwt.sign(data, SECRET_KEY, { expiresIn: TIME_OUT_TOKEN });
  return token;
}
const checkLogin = (req, res, next) => {
  let token = req.headers['access_token'];
  let data_user = verifyToken(token);
  if (data_user) {
    req.data_user = data_user;
    next();
  }
  else {
    res.json({
      result: 'err',
      message: 'Invalid Token'
    });
  }
}
module.exports = {
  verifyToken,
  siginToken,
  checkLogin
}
