import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_client/views/HomePage.dart';
import 'package:mobile_client/views/LoginPage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const String _title = 'Todo App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
