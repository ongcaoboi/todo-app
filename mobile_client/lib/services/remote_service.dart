import 'dart:convert';

import 'package:mobile_client/global.dart';
import 'package:mobile_client/models/data.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  String token;

  RemoteService(this.token) {}

  Future<List<Todo>?> getPosts() async {
    final uri = Uri.parse(host + '/api/todos');
    final headers = {'Content-Type': 'application/json', 'access_token': token};

    var response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody["result"] == 'ok') {
        final todos = responseBody["data"].cast<Map<String, dynamic>>();
        print(todos);
        final listOfTodos = await todos.map<Todo>((json) {
          return Todo.fromJson(json);
        }).toList();
        return listOfTodos;
      }
    }
  }
}
