module.exports = (app) => {
  const todoList = require('../controllers/todoListController');
  const auth = require('../services/auth');

  app.route('/api/todos')
    .get(auth.checkLogin, todoList.get)
    .post(auth.checkLogin, todoList.store);

  app.route('/api/todos/:todoId')
    .get(auth.checkLogin, todoList.detail)
    .put(auth.checkLogin, todoList.update)
    .delete(auth.checkLogin, todoList.delete);

};
