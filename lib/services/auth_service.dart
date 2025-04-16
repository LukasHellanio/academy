import 'package:firebase_auth/firebase_auth.dart';
import 'package:encora_community/services/firestore_service.dart';
import 'package:encora_community/core/utils/global.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Function to log in the user with email and password
  Future<User?> loginWithEmail(String email, String password) async {
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
          // Save user data as a JSON (Map)
          currentUserData = userData;
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
}
