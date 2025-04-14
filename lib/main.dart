import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB4J_hJbO6aasDV9wAwdwUXQLQ7I05z95M",
      authDomain: "encora-community-app.firebaseapp.com",
      projectId: "encora-community-app",
      storageBucket: "encora-community-app.firebasestorage.app",
      messagingSenderId: "752694225568",
      appId: "1:752694225568:web:e34ee9d29106ef1ca2f7c5",
    ),
  );
  runApp(MaterialApp(home: EncoraAcademyLogin()));
}
