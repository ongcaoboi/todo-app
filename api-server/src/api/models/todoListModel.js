const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let todoListSchema = new Schema({
    title: {
        type: String,
        required: true,
        unique: true,
    },
    status: {
        type: Boolean,
        default: 0,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    }
});

module.exports = mongoose.model('todoList', todoListSchema);