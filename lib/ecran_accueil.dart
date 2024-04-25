import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vlr/Models/match.dart';
import 'package:vlr/api.dart';
import 'Models/article.dart';
import 'tiroir_nav.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  Future<List<Article>> futureArticles = fetchNews();
  Future<List<Match>> futureMatches = fetchMatches();
  List<Article> articles = [];
  List<Match> matches = [];


  @override
  void initState() {
    toListAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 50.0,
              autoPlay: true,
            ),
            items: matches.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                      ),
                    alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text('${i.team1} vs ${i.team2}', style: const TextStyle(fontSize: 16.0)),
                          Row(
                            children: [
                              Text(i.score1, style: const TextStyle(fontSize: 16.0)),
                              const Text(' - ', style: TextStyle(fontSize: 16.0)),
                              Text(i.score2, style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ],
                      ),
                  );
                },
              );
            }).toList(),
          ),
          Title(color: Colors.red, child: const Text('Articles', style: TextStyle(fontSize: 20.0)),),
          Expanded(child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.newspaper),
                        title: Text(
                            articles[index].title
                        ),
                        subtitle: Text(
                          articles[index].description,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }

  Future<void> toListAsync() async {
    matches = await futureMatches;
    articles = await futureArticles;
  }
}