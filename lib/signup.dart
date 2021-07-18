// @dart=2.9
import 'package:flutter/material.dart';
import 'package:tugas10_vaksin_dan_pcr/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> _emailSalah() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email salah'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Email yang anda masukan tidak valid'),
                Text('Yang bener coyyy'),
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

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController text_password = TextEditingController();

  bool securePassword = true;
  bool userNameValidate = false;
  bool emailValidate = false;
  bool passwordValidate = false;
  bool isLoading = false;

  bool validateUsername(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        userNameValidate = true;
      });
      return false;
    }
    setState(() {
      userNameValidate = false;
    });
    return true;
  }

  bool validateEmail(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        emailValidate = true;
      });
      return false;
    } else if (EmailValidator.validate(userInput)) {
      setState(() {
        emailValidate = false;
      });
      return true;
    }
    return false;
  }

  bool validatePassword(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        passwordValidate = true;
      });
      return false;
    }
    setState(() {
      passwordValidate = false;
    });
    return true;
  }

  Future<void> _daftarBerhasil() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Succeeesssss'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Daftar berhasil'),
                Text('Please Log in'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainApp()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> signup(String username, String password, String email) async {
    // print(username.toString());
    // print(password.toString());
    final String apiUrl = "https://rizkiwebdr.000webhostapp.com/pm/adduser";

    var apiResult = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          "password": password,
          "email": email
        }));

    var result = json.decode(apiResult.body);
    print(jsonEncode(<String, String>{
      'username': username,
      "password": password,
      "email": email
    }));
    if (result['status'] == 'success') {
      setState(() {
        isLoading = false;
        _daftarBerhasil();
      });

      return "success";
    } else {
      setState(() {
        isLoading = false;
      });
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
                              errorText: userNameValidate
                                  ? 'Please enter a Username'
                                  : null,
                              filled: true,
                              fillColor: Color(0xFFF6E1E1),
                              focusColor: Color(0xFFBB7A48),
                              labelText: "username",
                              // suffix: Icon(Icons.remove_red_eye_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: username,
                          // obscureText: true,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              errorText:
                                  emailValidate ? 'Please enter a Email' : null,
                              filled: true,
                              fillColor: Color(0xFFF6E1E1),
                              labelText: "email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: email,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              errorText: passwordValidate
                                  ? 'Please enter a Password'
                                  : null,
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
                        GestureDetector(
                            onTap: () {
                              bool a = validateUsername(username.text);
                              bool b = validateEmail(email.text);
                              bool c = validatePassword(text_password.text);

                              if (!b) {
                                _emailSalah();
                                email.clear();
                              }

                              if (a && b && c) {
                                signup(username.text, text_password.text,
                                    email.text);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Center(
                                  child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: Color(0XFFECF0F3),
                                  borderRadius: BorderRadius.circular(50)),
                            )),
                        Container(
                          margin: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
