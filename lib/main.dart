import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // Ajoute tous tes providers ici
      ],
      child: MyApp(),
    ),
  );
}
