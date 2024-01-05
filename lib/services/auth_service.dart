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
}
