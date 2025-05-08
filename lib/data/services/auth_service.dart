import 'package:firebase_auth/firebase_auth.dart';
import 'package:encora_community/data/services/firestore_service.dart';
import 'package:encora_community/data/models/user_header_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Login with email and password
  Future<Map<String, dynamic>?> loginWithEmail(
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
        final userData = await _firestoreService.getUserData(user.uid) ?? {};
        return {'uid': user.uid, ...userData};
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  // Get current user's UID
  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user is currently logged in.');
    }
  }

  Future<UserHeaderModel?> getLoggedUser() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userData = await _firestoreService.getUserData(user.uid);

      if (userData != null) {
        return UserHeaderModel(
          name: userData['name'] ?? 'Guest',
          avatarUrl: userData['avatarUrl'] ?? '',
          description: userData['userType'] ?? 'Unknown',
        );
      }
    }

    return null;
  }

  // Register a new user
  Future<Map<String, dynamic>?> registerUser({
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

        return {
          'uid': user.uid,
          'name': name,
          'email': email,
          'avatarUrl': avatarUrl,
          'userType': userType,
        };
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
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
