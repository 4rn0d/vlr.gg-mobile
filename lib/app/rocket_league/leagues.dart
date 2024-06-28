import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart' as api;

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {

  toList() {
     api.fetchEvents().then((value) => print(value));
  }

  @override
  void initState() {
    super.initState();
    toList();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
