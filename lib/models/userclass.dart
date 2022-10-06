import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final DateTime registeredSince;

  User(this.id, this.firstname, this.lastname, this.email, this.password,
      this.username, this.registeredSince);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as String,
      json['firstname'] as String,
      json['lastname'] as String,
      json['email'] as String,
      json['password']
          as String, // TODO: eventually remove password because it shouldn't be transferred via the internet
      json['username'] as String,
      (json['registered_since'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson(User instance) {
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
