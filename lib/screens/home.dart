import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<String> _addUserData() async {
  //   User user = User(
  //       email: 'hussain.schrammbrater@küchengeschirr24.com',
  //       username: 'hossihussi',
  //       firstname: 'Hussain',
  //       lastname: 'Schrammbrater',
  //       admin: true,
  //       registeredSince: DateTime.now());
  //   return await db.addData(user);
  // }

  // Future<List<User>> _getUserData() async {
  //   List<User> users = await db.getData();
  //   return users;
  // }

  // Widget _buildList(context, snapshot) {
  //   return ListView.builder(
  //     itemCount: snapshot.length,
  //     itemBuilder: (context, index) {
  //       User user = snapshot[index];
  //       return Column(
  //         children: [
  //           Text(user.username),
  //         ],
  //       );
  //     },
  //     padding: const EdgeInsets.only(top: 20),
  //   );
  // }

  // Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  //   // final user = User.fromSnapshot(snapshot);
  //   // print(user.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensa-App-XXL-Extendet-Mega-Krass-Genial'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.group_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
