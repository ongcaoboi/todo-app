import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_client/views/HomePage.dart';
import 'package:mobile_client/views/RegisterPage.dart';
// import 'package:mobile_client/screens/HomePage.dart';
import 'package:mobile_client/models/data.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/global.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.email, this.password}) : super(key: key);

  String? email;
  String? password;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formLoginKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.email != null && widget.password != null) {
        emailController.text = widget.email!;
        passwordController.text = widget.password!;
        print(emailController.text);
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formLoginKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welcome to Todo App ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) => validateEmail(value),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) =>
                      value != '' ? null : "Password not null",
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      child: const Text('Login'), onPressed: () => Login())),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => RegisterPage())),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    if (_formLoginKey.currentState!.validate()) {
      try {
        await getApiLogin();
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error')),
        );
      }
    }
  }

  Future<void> getApiLogin() async {
    final uri = Uri.parse(host + '/api/login');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'email': emailController.text,
      'password': passwordController.text
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    String msg;
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody["result"] == 'ok') {
        String token = responseBody["token"];
        var userData = await getUser(token);
        if (userData != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyHomePage(
                  token: token,
                  name: userData["name"].toString(),
                  email: userData["email"].toString())));
        }
        return;
      } else {
        if (responseBody["message"] == "Error") {
          msg = "Account not found!";
        } else {
          msg = responseBody["message"];
        }
      }
    } else {
      msg = "Error: " + response.statusCode.toString();
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

  getUser(String token) async {
    final uri = Uri.parse(host + '/api/user');
    final headers = {'Content-Type': 'application/json', 'access_token': token};
    final encoding = Encoding.getByName('utf-8');

    var response = await http.get(uri, headers: headers);

    String msg;
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody["result"] == 'ok') {
        return responseBody["data"];
      } else {
        msg = "Load data user error! message: " + responseBody["message"];
      }
    } else {
      msg = "Load data user error! code: " + response.statusCode.toString();
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return null;
  }
}
