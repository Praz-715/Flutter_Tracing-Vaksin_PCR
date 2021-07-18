// @dart=2.9
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tugas10_vaksin_dan_pcr/dashboard.dart';
import 'package:tugas10_vaksin_dan_pcr/signup.dart';
import 'package:tugas10_vaksin_dan_pcr/test.dart';

import 'datapcr.dart';
import 'datavaksin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController text_username = TextEditingController();
  TextEditingController text_password = TextEditingController();
  bool status = false;
  bool isLoading = false;
  bool securePassword = true;

  Future<void> _loginGagal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Gagal'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Username atau Password Salah'),
                Text('Please Sign up'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> login(String username, String password) async {
    // print(username.toString());
    // print(password.toString());
    final String apiUrl = "https://rizkiwebdr.000webhostapp.com/pm/user";

    var apiResult = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, "password": password}));

    var result = json.decode(apiResult.body);
    print(jsonEncode(
        <String, String>{'username': username, "password": password}));
    if (result['status'] == 'success') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      setState(() {
        isLoading = false;
      });
      return "success";
    } else {
      setState(() {
        isLoading = false;
      });
      _loginGagal();
      return "fail";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA3DBFA),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Text("TRACKING DATA VAKSIN DAN LAYANAN PCR",
                      style:
                          TextStyle(fontSize: 36, fontFamily: 'RhodiumLibre'),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF6E1E1),
                              labelText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: text_username,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF6E1E1),
                              focusColor: Color(0xFFBB7A48),
                              labelText: "Password",
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      securePassword
                                          ? securePassword = false
                                          : securePassword = true;
                                    });
                                  },
                                  icon: securePassword
                                      ? Icon(
                                          Icons.remove_red_eye,
                                        )
                                      : Icon(Icons.visibility_off)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: text_password,
                          obscureText: securePassword,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              FlutterSwitch(
                                width: 65.0,
                                height: 30.0,
                                // valueFontSize: 25.0,
                                // toggleSize: 45.0,
                                value: status,
                                // borderRadius: 30.0,
                                // padding: 8.0,
                                // showOnOff: true,
                                onToggle: (val) {
                                  setState(() {
                                    status = val;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Remember me"),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              login(text_username.text, text_password.text);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Center(
                                  child: Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: Color(0XFFECF0F3),
                                  borderRadius: BorderRadius.circular(50)),
                            )),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("or"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              height: 50,
                              width: 50,
                              // color: Colors.blue,
                              child: Image(
                                image: AssetImage("images/google.png"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              height: 50,
                              width: 50,
                              // color: Colors.blue,
                              child: Image(
                                image: AssetImage("images/fb.png"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              height: 50,
                              width: 50,
                              // color: Colors.blue,
                              child: Image(
                                image: AssetImage("images/twitter.png"),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 70),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text("belum punya akun?",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
