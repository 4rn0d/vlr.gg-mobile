import 'package:flutter/material.dart';
import 'tiroir_nav.dart';

// TODO Un ecran minimal avec un tres peu de code
class EcranA extends StatefulWidget {
  const EcranA({super.key});

  @override
  State<EcranA> createState() => _EcranAState();
}

class _EcranAState extends State<EcranA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        title: const Text('Ecran A'),
      ),
      body: const Text('Tu as navigué vers A'),
    );
  }
}