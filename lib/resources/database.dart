import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/firebase_options.dart';

class TableDataRepo {
  // TODO: Add connection detection (not relevant for web release)
  static final db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> collection =
      db.collection('tables');

  static Future<QuerySnapshot> getAllData() async {
    QuerySnapshot data = await collection.get();
    return data;
  }

  static Future<bool> setData(Map<String, dynamic> data) async {
    try {
      await collection.add(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
