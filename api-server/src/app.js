const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

let todoRouters = require('./routers/todoListRouters');
todoRouters(app);

let userRouters = require('./routers/userRouters');
userRouters(app);

app.use((req, res) => {
  res.status(404).send({ url: req.originalUrl + ' not found' })
});

module.exports = app;
