import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/firebase_options.dart';
import '../models/userclass.dart';

// class DataRepo {
//   final CollectionReference collection = db.collection('users');

//   Stream<QuerySnapshot> getStream() {
//     collection.
//     return collection.snapshots();
//   }

//   Future<DocumentReference> addUser(User user) {
//     return collection.add(user.toJson());
//   }

//   // 4
//   void updateUser(User user) async {
//     await collection.doc(user.id).update(user.toJson());
//   }

//   // 5
//   void deleteUser(User user) async {
//     await collection.doc(user.id).delete();
//   }
// }

// class UserDataRepo {
//   final db = FirebaseFirestore.instance;

//   Future<User> getData() async {
//     QuerySnapshot<Map<String, dynamic>> users = await db.collection('users').get();
//     users.docs.asMap();
//   }

// }
