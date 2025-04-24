import 'package:encora_community/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:encora_community/data/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Function to log in the user with email and password
  Future<User?> loginWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        // Fetch user data from Firestore
        final userData = await _firestoreService.getUserData(user.uid);

        if (userData != null) {
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          userProvider.setUser(
            name: userData['name'],
            email: userData['email'],
            avatarUrl: userData['avatarUrl'],
            userType: userData['type'],
          );
        }

        return user;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  Future<User?> registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    String avatarUrl = '',
    required String userType,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        await _firestoreService.createUserData(
          uid: user.uid,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          userType: userType,
        );

        Provider.of<UserProvider>(context, listen: false).setUser(
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          userType: userType,
        );

        return user;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }
}
