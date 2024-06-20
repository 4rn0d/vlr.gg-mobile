import 'package:flutter/material.dart';
import 'package:vlr/home_screen.dart';
import 'package:vlr/news.dart';
import 'package:vlr/service.dart';

class Default extends StatefulWidget {
  const Default({super.key});

  @override
  State<Default> createState() => _DefaultState();
}

class _DefaultState extends State<Default> {

  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    News(),
    News(),
    News(),
    News()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index)
        {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: const Color(0xffda626c),
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.article),
            icon: Icon(Icons.article_outlined),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.stadium),
            icon: Icon(Icons.stadium_outlined),
            label: 'Ligues',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.star),
            icon: Icon(Icons.star_outline),
            label: 'Favorite',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    appBar: AppBar(
      backgroundColor: const Color(0xffda626c),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
      title: const Text('Valorant'),
    ),
    body: _screens[_selectedIndex]
    );
  }
}