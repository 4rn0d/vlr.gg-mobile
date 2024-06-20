import 'package:flutter/material.dart';
import 'package:vlr/default.dart';
import 'article_screen.dart';
import 'home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Default(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2f3337),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFd4d4d4)),
          bodyMedium: TextStyle(color: Color(0xFFd4d4d4)),
          bodySmall: TextStyle(color: Color(0xFFd4d4d4)),
        ),
      ),
    );
  }
}