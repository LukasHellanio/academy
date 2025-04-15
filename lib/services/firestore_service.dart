import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch user type from Firestore
  Future<String?> getUserType(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        return doc.data()?['type'];
      } else {
        print("User document does not exist.");
        return null;
      }
    } catch (e) {
      print("Error fetching user type: $e");
      return null;
    }
  }
}
