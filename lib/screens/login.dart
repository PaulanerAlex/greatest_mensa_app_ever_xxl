import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Future<bool>_loginUser() async {
  //   return
  // }

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
                  'Log in',
                  style: TextStyle(fontSize: 40, fontFamily: 'noto sans'),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
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
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                obscureText: true,
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
                  child: const Text('Log In'),
                  onPressed: () {},
                )),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
