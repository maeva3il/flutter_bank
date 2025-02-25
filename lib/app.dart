import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/screens/main_screen.dart'; // ✅ Ajoute l'import correct

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // ✅ Fournit UserProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dépenses App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(), // ✅ On affiche MainScreen au lieu de HomeScreen
      ),
    );
  }
}
