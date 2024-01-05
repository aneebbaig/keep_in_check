import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _obscurePass = true;
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  String? _errorText;
  bool _registerMode = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final AuthService _authService = AuthService();

  bool get registerMode => _registerMode;

  void toggleRegister() {
    _registerMode = !_registerMode;
    notifyListeners();
  }

  bool get obscurePass => _obscurePass;

  void togglePass() {
    _obscurePass = !_obscurePass;
    notifyListeners();
  }

  String? get errorText => _errorText;

  set errorText(String? value) {
    _errorText = value;
    notifyListeners();
  }

  void authenticateUsingEmailAndPassword(BuildContext context) async {
    try {
      final response = await _authService.signinWithEmailAndPassword(
        email.text,
        password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) {
        return;
      }
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(" No user found for that email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      }
    }
  }
}
