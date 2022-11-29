import 'dart:html';
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/auth.dart';
import 'package:greatest_mensa_app_ever_xxl/screens/home.dart';
import 'package:greatest_mensa_app_ever_xxl/screens/login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailFieldController = TextEditingController();
  // final _userNameFieldController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _passwordFieldController = TextEditingController();

  Future<bool> _registerUser(BuildContext context) async {
    String email = _emailFieldController.text;
    String password = _passwordFieldController.text;
    try {
      UserCredential user = await Auth().registerWithPassword(password, email);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))); // TODO: add error logging
      return false;
    }
    // TODO: Add comparison/overwriting of old credentials
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 40, fontFamily: 'noto sans'),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: _emailFieldController,
                onSubmitted: (input) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // no border but
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            //   child: TextField(
            //     controller: _userNameFieldController,
            //     onSubmitted: (input) =>
            //         FocusScope.of(context).requestFocus(_passwordFocusNode),
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.grey[300],
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide.none, // no border but
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       labelText: 'Username',
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: _passwordFieldController,
                focusNode: _passwordFocusNode,
                obscureText: true,
                onSubmitted: (value) async {
                  bool result = await _registerUser(context);
                  if (result) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // no border but
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Confirm'),
                onPressed: () async {
                  bool result = await _registerUser(context);
                  if (result) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }, // TODO: Add transition to register screen
                child: Text(
                  'Already registered? Login',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
