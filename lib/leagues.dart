import 'package:flutter/material.dart';
import 'package:vlr/Models/event.dart';
import 'package:vlr/service.dart';

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {

  List<Event> _leagues = [];

  Future<void> toListAsync() async {
    fetchEvents().then((value) {
      setState(() {
        _leagues = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    toListAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _leagues.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 75,
              child: Card(
                color: Color(0xFF535c65),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.network(_leagues[index].img)
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Expanded(
                        child: Text(_leagues[index].league)
                      ),
                      TextButton(
                        onPressed: (){
                          !_leagues[index].isFavorite;
                        },
                        child: !_leagues[index].isFavorite ?
                          const Icon(Icons.star_outline, color: Colors.white,):
                          const Icon(Icons.star, color: Colors.white,)
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
