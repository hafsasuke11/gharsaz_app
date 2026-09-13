import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String userName = '';

  String phoneNumber = '';

  void setUser(
      String name,
      String phone,
      ) {
    userName = name;

    phoneNumber = phone;

    notifyListeners();
  }

  void logout() {
    userName = '';

    phoneNumber = '';

    notifyListeners();
  }
}