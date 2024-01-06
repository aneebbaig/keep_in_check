import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/services/auth_service.dart';
import 'package:keep_in_check/services/snackbar_service.dart';
import 'package:keep_in_check/views/home_view.dart/home_view.dart';

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

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final AuthService _authService = AuthService();

  bool get isRegister => _registerMode;

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

  void signInUsingEmailAndPassword(BuildContext context) async {
    setIsLoading(true);

    try {
      UserCredential user = await _authService.signinWithEmailAndPassword(
        email.text,
        password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) {
        return;
      }
      switch (e.code) {
        case 'user-not-found':
          SnackbarService.showSnackbar(context, "No user found for that email");
          break;
        case 'wrong-password':
          SnackbarService.showSnackbar(
              context, "Wrong password provided for that user");
          break;
        case 'invalid-credential':
          SnackbarService.showSnackbar(context, "User not found");
          break;
        default:
          SnackbarService.showSnackbar(
              context, "Something went wrong. Please try again");
          break;
      }
    }
    setIsLoading(false);
  }

  void createUserUsingEmailAndPassword(BuildContext context) async {
    setIsLoading(true);
    try {
      await _authService.createUserWithEmailAndPassword(
        email.text,
        password.text,
      );
      AppRouter.pushReplacementNamed(HomeView.route);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) {
        return;
      }

      switch (e.code) {
        case 'email-already-in-use':
          SnackbarService.showSnackbar(context, "email-already-in-use");
          break;
        case 'invalid-email':
          SnackbarService.showSnackbar(context, "invalid-email");
          break;
        case 'weak-password':
          SnackbarService.showSnackbar(context, "weak-password");
          break;
        default:
          SnackbarService.showSnackbar(
              context, "Something went wrong. Please try again");
          break;
      }
    }
    setIsLoading(false);
  }
}
