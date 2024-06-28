import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/rocket_league.dart';
import 'package:vlr/app/valorant/valorant.dart';
import 'app/valorant/article_screen.dart';
import 'app/valorant/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RocketLeague(),
      theme: ThemeData(
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