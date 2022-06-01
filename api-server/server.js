const { DB_URI, port, SECRET_KEY } = require('./src/config/index');
const app = require('./src/app');
const mongooes = require('mongoose');

if (DB_URI) {
  mongooes.connect(DB_URI)
    .then(res => {
      console.log("DB Connected!");
      app.listen(port, () => {
        console.info('todo app restful api server started on: ' + port);
        console.log('-----------------------------------------------');
      });
    })
    .catch(err => {
      console.error(Error, err.message);
      console.error('Todo app restful api server is stopped!');
      console.log('-----------------------------------------------');
    });
}
else {
  console.error('Environment Variable not found');
  console.error('Todo app restful api server is stopped!');
  console.log('-----------------------------------------------');
}
