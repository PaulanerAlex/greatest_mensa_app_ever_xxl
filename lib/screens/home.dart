import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/auth.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/database.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/parse_svg.dart';
import 'package:touchable/touchable.dart';

import '../widgets/mensa_path_painter.dart';

class HomeScreen extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  String currentModel;
  HomeScreen({this.currentModel = '1og.svg'});

  @override
  State<HomeScreen> createState() => _HomeScreenState(currentModel);
}

class _HomeScreenState extends State<HomeScreen> {
  String currentModel;

  _HomeScreenState(this.currentModel);

  Future<MensaSvgModel> _getDataAndImage(back, svgPathKey) async {
    MensaSvgModel model =
        await loadSvgImage(back: true, svgPathKey: currentModel, user: 'test');
    QuerySnapshot tableData = await TableDataRepo.getAllData();
    return model;
  }
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
      body: FutureBuilder<MensaSvgModel>(
        future: _getDataAndImage(true, currentModel),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  // constraints: BoxConstraints(
                  // minHeight: snapshot.data.sizeh,
                  // minWidth: snapshot.data.sizew,
                  // ),
                  height: snapshot.data.sizeh,
                  width: snapshot.data.sizew,
                  child: CanvasTouchDetector(
                    gesturesToOverride: const [
                      GestureType.onTapDown,
                      // GestureType.onTapUp,
                      // GestureType.onSecondaryTapDown,
                    ],
                    builder: (context) {
                      print('BUILD');
                      return CustomPaint(
                        size: const Size.fromWidth(200),
                        painter: MensaPainter(
                            context: context, model: snapshot.data),
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            throw (snapshot.error!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // body: SvgPicture.asset(
      // 'mensa_layout.svg',
      // semanticsLabel: 'Mensa layout',
      // ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentModel = '1og.svg';
                });
                // ALTERNATIV:
                // ----------------
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             HomeScreen(currentModel: '1og.svg')));
                // ----------------
              }, // TODO: add function move up a floor
              child: const Icon(Icons.move_down_rounded),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentModel = '2og.svg';
                });
                // ALTERNATIVELY:
                // ---------------
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => HomeScreen(
                //               currentModel: '2og.svg',
                //             )));
                // ---------------
              }, // TODO: add function move up a floorch
              child: const Icon(Icons.move_up_rounded),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: FloatingActionButton(
              onPressed: () async {
                await FirebaseAuth.instance.setPersistence(Persistence.NONE);
                print('TEST');
                bool data = await TableDataRepo.setData(
                  <String, dynamic>{
                    'table_id': 'test',
                    'time': Timestamp.now(),
                    'user': 'paul'
                  },
                );
                print(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Tap a table to tell other users where you sit.'),
                  ),
                );
                // loadSvgImage(back: true, svgPathKey: 'mensa_layout.svg');
              },
              child: const Icon(Icons.group_add),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
