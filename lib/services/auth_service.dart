import 'package:firebase_auth/firebase_auth.dart';
import 'package:encora_community/services/firestore_service.dart'; // Importando o FirestoreService
import 'package:encora_community/core/utils/global.dart'; // Importando a variável global

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Função para logar o usuário com email e senha
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        // Buscar dados do usuário no Firestore
        final userData = await _firestoreService.getUserData(user.uid);

        if (userData != null) {
          // Salvar os dados do usuário como um JSON (Map)
          currentUserData = userData; // Salvando os dados do usuário no Map
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
