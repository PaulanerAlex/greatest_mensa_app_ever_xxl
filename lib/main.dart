import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/auth.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/firebase_options.dart';
import 'package:greatest_mensa_app_ever_xxl/screens/home.dart';
import 'package:greatest_mensa_app_ever_xxl/screens/login.dart';
import 'package:greatest_mensa_app_ever_xxl/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<bool> _checkLoginState() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool auth_state = await Auth().checkLoginState();
    print(auth_state);
    print('THIS WAS THE auth_state');
    return auth_state;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _checkLoginState(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
            snapshot.data! ? HomeScreen() : LoginScreen(),
        // builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
        //     snapshot.data! ? MyHomePage() : RegisterScreen(),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
