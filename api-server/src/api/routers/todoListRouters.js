module.exports = (app) => {
    const todoList = require('../controllers/todoListController');

    app.route('/todos')
        .get(todoList.get)
        .post(todoList.store);

    app.route('/todos/:todoId')
        .get(todoList.detail)
        .put(todoList.update)
        .delete(todoList.delete);
};