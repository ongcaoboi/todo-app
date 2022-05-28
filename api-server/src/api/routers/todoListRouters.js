module.exports = (app) => {
    const todoList = require('../controllers/todoListController');

    app.route('/api/todos')
        .get(todoList.get)
        .post(todoList.store);

    app.route('/api/todos/:todoId')
        .get(todoList.detail)
        .put(todoList.update)
        .delete(todoList.delete);
};