# TODO-APP

This repo is api todo app using nodejs and mongodb

## Get stated

- Clone project and run command:

```sh
git clone https://github.com/ongcaoboi/todo-app.git

cd ./todo-app

docker-compose up

```

- run npm start BEFORE run docker-composer up

## How to use?

- You can use postman to test api
- User api

  - POST (login) : http://localhost:3000/api/login
  - POST (register) : http://localhost:3000/api/register
  - POST (changePassword) : http://localhost:3000/api/changePassword

- Todo api

  - GET (all) | POST (create) : http://localhost:3000/api/todos
  - GET (detail) | PUT (update) | DELETE : http://localhost:3000/api/todos/todoId

## Use-postman

### Create account
  
- POST to http://localhost:3000/api/register
- Body raw, type json
   
 ``` json
{
  "name": "Example",
  "email": "example@email.com",
  "password": "123456"
}
 ```
- See response

``` json
{
    "result": "ok",
    "data": {
        "name": "example",
        "email": "example@gmail.com",
        "password": "e10adc3949ba59abbe56e057f20f883e",
        "_id": "6297baa0287d65e97e083ad3",
        "createdAt": "2022-06-01T19:14:40.324Z",
        "__v": 0
    }
}
```

### Login

- POST to http://localhost:3000/api/login 
- Body raw, type json

``` json
{
    "email": "example@gmail.com",
    "password": "123456"
}
```
- See response

``` json
{
    "result": "ok",
    "token": "value_token"
}
```

- Now, you can use token to call api /api/todos

### Create Todo

- POST to http://localhost:3000/todos
- body raw, type json

```json

{
  "title": "Learn Git"
}

```
- Headers key 'access_token' : 'value_token', see response
```json
{
    "result": "ok",
    "data": {
        "title": "Learn Git",
        "status": false,
        "idUser": "6297baa0287d65e97e083ad3",
        "_id": "6297bce0287d65e97e083ad6",
        "createdAt": "2022-06-01T19:24:16.208Z",
        "__v": 0
    }
}
```
- ...

## Use Flutter app 

- Require: Clone project, run api-server.
- Change host name ./mobile-client/lib/global.dart.
  
### Using android devices 

- Connect your pc and device to the same network.
- host = ipv4 pc.

### Using emulator 

- host = 10.0.2.2

### run mobile app with flutter

```sh
 run --no-sound-null-safety
```

Test app!

Goodlook!
