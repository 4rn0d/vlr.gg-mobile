import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'ecran_a.dart';
import 'article_screen.dart';

class LeTiroir extends StatefulWidget {
  const LeTiroir({super.key});

  @override
  State<LeTiroir> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          color: const Color(0xFF2f3337),
          height: 200,
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.ac_unit),
          title: const Text("Accueil"),
          onTap: () {
            // TODO ferme le tiroir de navigation
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            // Then close the drawer
          },
        ),

        // TODO le tiroir de navigation ne peut pointer que vers des
        // ecran sans paramtre.
        ListTile(
          dense: true,
          leading: const Icon(Icons.ac_unit),
          title: const Text("Ecran A"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EcranA(),
              ),
            );
            // Then close the drawer
          },
        ),
      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFF2f3337),
        child: listView,
      ),
    );
  }
}