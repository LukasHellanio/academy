import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? name;
  String? email;
  String? avatarUrl;
  String? userType;

  void setUser({
    required String name,
    required String email,
    required String avatarUrl,
    required String userType,
  }) {
    this.name = name;
    this.email = email;
    this.avatarUrl = avatarUrl;
    this.userType = userType;
    notifyListeners();
  }

  void clearUser() {
    name = null;
    email = null;
    avatarUrl = null;
    userType = null;
    notifyListeners();
  }
}
