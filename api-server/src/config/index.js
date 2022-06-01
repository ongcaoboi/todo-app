require('dotenv').config();

let DB_URI = undefined;
let port = 3000;
let SECRET_KEY = 'default';
let TIME_OUT_TOKEN = '180s';

if (process.env.MONGO_DB_URI) {
  DB_URI = process.env.MONGO_DB_URI;
}

if (process.env.PORT) {
  port = process.env.PORT;
}

if (process.env.SECRET_KEY) {
  SECRET_KEY = process.env.SECRET_KEY;
}

if (process.env.TIME_OUT_TOKEN) {
  TIME_OUT_TOKEN = process.env.TIME_OUT_TOKEN;
}

module.exports = {
  DB_URI,
  port,
  SECRET_KEY,
  TIME_OUT_TOKEN
};
