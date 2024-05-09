import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
