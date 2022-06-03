import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_client/views/LoginPage.dart';
import 'package:mobile_client/models/data.dart';
import 'package:mobile_client/services/remote_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key, required this.token, required this.name, required this.email})
      : super(key: key);

  String name;
  String email;
  String token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo>? todos;
  var isLoaded = false;

  int sumAll = 0;
  int unComplete = 0;
  int complete = 0;

  int indexState = 0;

  TextEditingController inputTodoController = TextEditingController();

  static const TextStyle optionStyle = TextStyle(
      fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    //fetch data from API
    loadPageOfIndex(indexState);
  }

  void loadPageOfIndex(int index) async {
    setState(() {
      switch (index) {
        case 0:
          getData();
          break;
        case 1:
          loadTabUnComplete();
          break;
        case 2:
          loadTabComplete();
          break;
      }
      indexState = index;
    });
  }

  getData() async {
    todos = await RemoteService(widget.token).getPosts();
    if (todos != null) {
      setState(() {
        sumAll = todos!.length;
        int unComplete = 0;
        int complete = 0;
        todos!.forEach((element) {
          if (element.status) {
            complete++;
          } else {
            unComplete++;
          }
        });
        this.complete = complete;
        this.unComplete = unComplete;
        isLoaded = true;
      });
    }
  }

  loadTabUnComplete() async {
    await getData();
    setState(() {
      List<Todo> todos_ = <Todo>[];
      todos!.forEach((element) {
        if (!element.status) {
          todos_.add(element);
        }
      });
      todos = todos_;
    });
  }

  loadTabComplete() async {
    await getData();
    setState(() {
      List<Todo> todos_ = <Todo>[];
      todos!.forEach((element) {
        if (element.status) {
          todos_.add(element);
        }
      });
      todos = todos_;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.name,
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              accountEmail: Text(widget.email,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://i.pinimg.com/736x/a7/20/d9/a720d936dcf82fd9fd6f9e882d023c32.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://c.wallhere.com/photos/f5/57/Moon_sky_sunset-132595.jpg!d'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Add'),
              onTap: () => {_openPopup(context)},
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All'),
              trailing: ClipOval(
                child: Container(
                  color: Colors.blue,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      sumAll.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => {Navigator.pop(context), loadPageOfIndex(0)},
            ),
            ListTile(
              leading: const Icon(Icons.playlist_remove),
              title: const Text('To do list'),
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      unComplete.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => {Navigator.pop(context), loadPageOfIndex(1)},
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_check),
              title: const Text('Completed'),
              trailing: ClipOval(
                child: Container(
                  color: Colors.green,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      complete.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => {Navigator.pop(context), loadPageOfIndex(2)},
            ),
            SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('You want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: logout,
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('You want to exit?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: todos?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () =>
                    complateTodo(todos![index].id, todos![index].status),
                onLongPress: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('You want to delete?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              removeTodo(todos![index].id),
                              Navigator.pop(context)
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                        child: (todos![index].status
                            ? const Icon(
                                Icons.check_box,
                                color: Colors.green,
                              )
                            : const Icon(Icons.check_box_outline_blank)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (todos![index].status
                                ? Text(
                                    todos![index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  )
                                : Text(
                                    todos![index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Add Todo",
        content: Column(
          children: <Widget>[
            TextField(
              controller: inputTodoController,
              decoration: InputDecoration(
                icon: Icon(Icons.edit),
                labelText: 'title',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => addTodo(context),
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  addTodo(context) async {
    String msg = '';
    String title = inputTodoController.text;
    if (title == "" || title == null) {
      msg = "Title require not null!";
    } else {
      final uri = Uri.parse(host + '/api/todos');
      final headers = {
        'Content-Type': 'application/json',
        'access_token': widget.token
      };
      Map<String, dynamic> body = {
        'title': title,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody["result"] == 'ok') {
          inputTodoController.text = '';
          Navigator.pop(context);
          loadPageOfIndex(indexState);
          return;
        } else {
          msg = responseBody["message"];
        }
      } else {
        msg = "Eroor! code: " + response.statusCode.toString();
      }
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void complateTodo(String id, bool status) async {
    String msg = '';
    final uri = Uri.parse(host + '/api/todos/' + id);
    final headers = {
      'Content-Type': 'application/json',
      'access_token': widget.token
    };
    Map<String, dynamic> body = {
      'status': !status,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http.put(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody["result"] == 'ok') {
        loadPageOfIndex(indexState);
        return;
      } else {
        msg = responseBody["message"];
      }
    } else {
      msg = "Eroor! code: " + response.statusCode.toString();
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void removeTodo(String id) async {
    String msg = '';
    final uri = Uri.parse(host + '/api/todos/' + id);
    final headers = {
      'Content-Type': 'application/json',
      'access_token': widget.token
    };
    final encoding = Encoding.getByName('utf-8');

    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody["result"] == 'ok') {
        loadPageOfIndex(indexState);
        return;
      } else {
        msg = responseBody["message"];
      }
    } else {
      msg = "Eroor! code: " + response.statusCode.toString();
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void logout() {
    Navigator.pop(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
