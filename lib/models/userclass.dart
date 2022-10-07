import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String? password;
  DateTime? registeredSince;
  final bool? admin;

  User(
      {this.id,
      this.password,
      this.admin,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.email,
      this.registeredSince});

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(
      username: json['username'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      registeredSince: (json['registeredSince'] as Timestamp).toDate(),
    );
    return user;
  }

  // factory User.fromSnapshot(DocumentSnapshot snapshot) {
  //   final newUser = User.fromJson(snapshot.data() as Map<String, dynamic>);
  //   newUser.id = snapshot.reference.id;
  //   return newUser;
  // }

  // Map<String, dynamic> toJson() => _usersToJson(this);

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> varList = [];
    if (id != null) {
      varList.add({'id': id});
    }
    if (firstname != null) {
      varList.add({'firstname': firstname});
    }
    if (lastname != null) {
      varList.add({'lastname': lastname});
    }
    if (password != null) {
      varList.add({'password': password});
    }
    if (email != null) {
      varList.add({'email': email});
    }
    if (username != null) {
      varList.add({'username': username});
    }
    if (registeredSince != null) {
      varList.add({'registeredSince': registeredSince});
    }
    Map<String, dynamic> returnMap = Map();
    for (var i in varList) {
      returnMap.addAll(i);
    }
    return returnMap;
    // return <String, dynamic>{
    // 'id': instance.id,
    // 'firstname': instance.firstname,
    // 'lastname': instance.lastname,
    // 'email': instance.email,
    // 'password': instance.password,
    // 'username': instance.username,
    // 'registered_since': instance.registeredSince,
    // };
  }

  @override
  String toString() => 'User<$username>';
}
