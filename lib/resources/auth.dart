import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithPassword(
      String password, String emailAddress) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception(1); // The password provided is too weak.
      } else if (e.code == 'email-already-in-use') {
        throw Exception(2); // The account already exists for that email.
      } else {
        throw Exception(e.toString()); // An error occured:
      }
    } catch (e) {
      throw Exception(e.toString()); // An error occured:
    }
  }

  Future<UserCredential> signInWithPassword(
      String password, String emailAddress) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception(1); // No user found for that email
      } else if (e.code == 'wrong-password') {
        throw Exception(2); // Wrong password provided for that user
      } else {
        throw Exception(e.toString()); // An error occured:
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> signOut() async {
    await auth.signOut();
    return true;
  }
}
