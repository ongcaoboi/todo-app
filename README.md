# TODO-APP

## Get stated

- Clone project and run command:

```sh
git clone https://github.com/ongcaoboi/todo-app.git

cd ./todo-app

docker-compose up

```

- get (all) | post (create) : http://localhost:3000/todos
- get (detail) | put (update) | delete : http://localhost:3000/todos/todoId

### Example create todo

- post to http://localhost:3000/todos
- body raw, type json

```json

{
  "title": "Learn git"
}

```
