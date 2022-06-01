module.exports = (app) => {
  const user = require('../controllers/userController');
  const auth = require('../services/auth');

  app.route('/api/users')
    .get(user.getAll);

  app.route('/api/login')
    .post(user.login);

  app.route('/api/register')
    .post(user.register);

  app.route('/api/changePassword')
    .post(auth.checkLogin, user.changePassword);
}
