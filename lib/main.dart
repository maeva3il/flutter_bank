import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Démarrage de l'application avant Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );

  // Lancer Firebase après l'UI
  await _initializeFirebaseServices();
}

Future<void> _initializeFirebaseServices() async {
  try {
    const String email = 'maeva@example.com';
    const String password = 'MaevaSecure123';

    // Vérifie si l'utilisateur est déjà connecté
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      try {
        // Vérifie si le compte existe avant de le créer
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("✅ Maeva est déjà inscrite et connectée !");
      } catch (e) {
        print("🔹 Création du compte de Maeva...");
        user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ))
            .user;
        print("✅ Compte créé pour Maeva !");
      }
    }

    // Ajout d'une tâche pour Maeva dans Firestore
    await FirebaseFirestore.instance.collection('tasks').add({
      'user': 'Maeva',
      'task': 'Apprendre Firebase et Flutter',
      'isComplete': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("✅ Tâche ajoutée pour Maeva dans Firestore !");

    // Écoute des modifications en temps réel
    FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        print("📌 Nouvelle tâche : ${doc.data()}");
      }
    });

    // Upload d'un fichier dans Firebase Storage
    final ref = FirebaseStorage.instance.ref('uploads/maeva_notes.txt');
    final file = File('C:/maeva_notes.txt');

    if (await file.exists()) {
      await ref.putFile(file);
      print("Fichier de Maeva uploadé avec succès !");
    } else {
      print("Le fichier de Maeva n'existe pas : ${file.path}");
    }
  } catch (e) {
    print("Erreur Firebase : $e");
  }
}
