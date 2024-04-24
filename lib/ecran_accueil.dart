import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vlr/api.dart';
import 'Models/Article.dart';
import 'tiroir_nav.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
    Future<List<Article>> futureArticles = fetchNews();
    List<Article> articles = [];
    var test = [];

  @override
  void initState() {
    super.initState();
    articlesList();
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
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                    alignment: Alignment.center,
                  );
                },
              );
            }).toList(),
          ),
          Title(color: Colors.red, child: Text('Articles', style: TextStyle(fontSize: 20.0)),),
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
                        leading: Icon(Icons.newspaper),
                        title: Text(
                            '${articles[index].title}'
                        ),
                        subtitle: Text(
                          '${articles[index].description}',
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
  Future<void> articlesList() async {
    articles = await futureArticles;
  }
}