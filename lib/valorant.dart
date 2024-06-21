import 'package:flutter/material.dart';
import 'package:vlr/home_screen.dart';
import 'package:vlr/leagues.dart';
import 'package:vlr/news.dart';
import 'package:vlr/service.dart';

class Valorant extends StatefulWidget {
  const Valorant({super.key});

  @override
  State<Valorant> createState() => _ValorantState();
}

class _ValorantState extends State<Valorant> {

  @override
  void initState() {
    super.initState();

    fetchLiveMatches();
    fetchUpcomingMatches();
    fetchCompletedMatches();
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    News(),
    Leagues(),
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