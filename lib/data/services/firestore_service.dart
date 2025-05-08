import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        return doc.data();
      } else {
        print("User document does not exist.");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> createUserData({
    required String uid,
    required String name,
    required String email,
    required String avatarUrl,
    required String userType,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'type': userType,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error creating user data: $e');
      throw Exception('Failed to save user data.');
    }
  }
}
