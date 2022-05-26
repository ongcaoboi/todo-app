require('dotenv').config();

let DB_URI = 'http://localhost:27017/Tododb';
let port = 3000;

if(process.env.MONGO_DB_URI) {
    DB_URI = process.env.MONGO_DB_URI;
}

if(process.env.PORT) {
    port = process.env.PORT;
}
module.exports = {
    DB_URI,
    port
};