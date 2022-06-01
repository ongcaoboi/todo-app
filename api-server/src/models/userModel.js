const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const validator = require('validator');
const TodoList = require('./todoModel');

let userSchema = new Schema({
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    validate: (value) => {
      return validator.isEmail(value);
    }
  },
  password: {
    type: String,
    required: true,
    validate: (value) => {
      return validator.isMD5(value);
    }
  },
  createdAt: {
    type: Date,
    default: Date.now,
  }
});

module.exports = mongoose.model('users', userSchema);
