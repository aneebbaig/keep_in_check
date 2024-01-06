import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  late UserCredential _user;

  UserCredential get user => _user;

  set user(UserCredential value) {
    _user = value;
    notifyListeners();
  }
}
