const { DB_URI, port } = require('./src/config/index');
const app = require('./src/app');
const mongooes = require('mongoose');
mongooes.connect(DB_URI)
    .then(res => {
        console.log("DB Connected!");
    })
    .catch(err => {
        console.log(Error, err.message);
    });


app.listen(port, () => {
    console.log('Todo app RESTful API server started on: ' + port);
    console.log('-----------------------------------------------');
});