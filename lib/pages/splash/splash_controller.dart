import 'package:encora_community/providers/user_provider.dart';
import 'package:encora_community/data/services/firestore_service.dart';
import 'package:encora_community/pages/dashboard/dashboard_page.dart';
import 'package:encora_community/pages/login/login_page.dart';
import 'package:encora_community/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SplashController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<bool> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final user = _auth.currentUser;

    if (user != null) {
      final userData = await _firestoreService.getUserData(user.uid);

      if (userData != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(
          name: userData['name'],
          email: userData['email'],
          avatarUrl: userData['avatarUrl'],
          userType: userData['type'],
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
        return true;
      }
    }

    return false;
  }

  void goToLoginPage(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void goToRegisterPage(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const RegisterPage()));
  }
}
