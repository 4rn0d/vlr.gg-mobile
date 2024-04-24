import 'package:flutter/material.dart';
import 'ecran_a.dart';
import 'ecran_accueil.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const EcranAccueil(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/ecrana': (context) => const EcranA(),
      '/accueil': (context) => const EcranAccueil(),
    };
  }
}