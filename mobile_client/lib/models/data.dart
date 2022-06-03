// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.status,
    required this.idUser,
    required this.createdAt,
    required this.v,
  });

  String id;
  String title;
  bool status;
  String idUser;
  DateTime createdAt;
  int v;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        title: json["title"],
        status: json["status"],
        idUser: json["idUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "status": status,
        "idUser": idUser,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
