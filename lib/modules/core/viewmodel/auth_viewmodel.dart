import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/services/auth_service.dart';
import 'package:keep_in_check/services/snackbar_service.dart';

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

  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  void signInUsingEmailAndPassword(BuildContext context) async {
    setIsLoading(true);

    try {
      await _authService.signinWithEmailAndPassword(
        email.text,
        password.text,
      );
      resetAllData();
      AppNavigator.pushReplacementNamed(AppRoutes.navbarRoute);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        String errorMessage = 'Something went wrong. Please try again';

        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No account found for the provided email address';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for that user';
            break;
          case 'invalid-credential':
            errorMessage = 'Email or password is incorrect';
            break;
        }

        SnackbarService.showSnackbar(errorMessage);
      }
    } catch (e) {
      // Log or display the actual error message during development
      if (context.mounted) {
        SnackbarService.showSnackbar('Unexpected error occurred');
      }
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> createUserDocument(String userId) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    // Create the user document along with the 'userData' subcollection and 'todoItems' document
    await users.doc(userId).set({
      'createdAt': FieldValue.serverTimestamp(),

      // Add any other initial user-related data you want to store
    });
  }

  void createUserUsingEmailAndPassword(BuildContext context) async {
    setIsLoading(true);

    try {
      final response = await _authService.createUserWithEmailAndPassword(
        email.text,
        password.text,
      );

      createUserDocument(response.user!.uid);
      resetAllData();
      AppNavigator.pushReplacementNamed(AppRoutes.loginRoute);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        String errorMessage = 'Something went wrong. Please try again';

        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'Email is already in use';
            break;
          case 'invalid-email':
            errorMessage = 'Please enter a valid email address';
            break;
          case 'weak-password':
            errorMessage = 'Password is too weak. Please choose a stronger one';
            break;
        }

        SnackbarService.showSnackbar(errorMessage);
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showSnackbar('Unexpected error occurred');
      }
    } finally {
      setIsLoading(false);
    }
  }

  void resetAllData() {
    email.text = '';
    password.text = '';
    confirmPassword.text = '';
    _obscurePass = true;
    emailFormKey = GlobalKey<FormState>();
    _errorText = null;
    _registerMode = false;
    _isLoading = false;
  }
}
