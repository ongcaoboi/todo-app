const TodoList = require('../models/todoListModel');

module.exports = {
    get: (req, res) => {
        TodoList.find({}, (err, todo) => {
            if(err) res.send(err);
            res.send(todo);
        });
    },
    store: (req, res) => {
        let todo = new TodoList(req.body);
        todo.save((err, todo) => {
            if(err) res.send(err);
            res.send(todo);
        });
    },
    detail: (req, res) => {
        TodoList.findById(req.params.todoId, (err, todo) => {
            if(err) res.send(err);
            res.send(todo);
        });
    },
    update: (req, res) => {
        TodoList.findOneAndUpdate({_id: req.params.todoId }, req.body, {new: true}, (err, todo) => {
            if(err) res.send(err);
            res.send(todo);
        });
    },
    delete: (req, res) => {
        TodoList.remove({_id: req.params.todoId }, (err, todo) => {
            if(err) res.send(err);
            res.send(todo);
        });
    },
}