import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String? password;
  final DateTime? registeredSince;
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

    print(user);

    return user;
  }

  // factory User.fromSnapshot(DocumentSnapshot snapshot) {
  //   final newUser = User.fromJson(snapshot.data() as Map<String, dynamic>);
  //   newUser.id = snapshot.reference.id;
  //   return newUser;
  // }

  Map<String, dynamic> toJson() => _usersToJson(this);

  _usersToJson(User instance) {
    return <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'registered_since': instance.registeredSince,
    };
  }

  @override
  String toString() => 'User<$username>';
}
