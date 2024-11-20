import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedOut = false;

  bool get isLoggedOut => _isLoggedOut;
  
  void login() {
    _isLoggedOut = false;
    notifyListeners();
  }

  void logout() {
    _isLoggedOut = true;
    notifyListeners();
  }
}