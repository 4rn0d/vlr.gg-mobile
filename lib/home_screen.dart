import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlr/api.dart';
import 'package:vlr/article_screen.dart';
import 'Models/article.dart';
import 'tiroir_nav.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Article> articles = [];
  var matches = [];


  @override
  void initState() {
    toListAsync().then((value) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2f3337),
        titleTextStyle: const TextStyle(color: Color(0xFFd4d4d4)),
        title: const Text('Accueil'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 60.0,
              autoPlay: true,
            ),
            items: matches.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          color: Color(0xFF535c65),
                      ),
                    alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.emoji_flags),
                                  Icon(Icons.emoji_flags),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 200.0,
                                    child: Text(i["team1"], style: const TextStyle(fontSize: 14.0),),
                                  ),
                                  SizedBox(
                                    width: 200.0,
                                    child: Text(i["team2"], style: const TextStyle(fontSize: 14.0)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  i["score1"],
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFd4d4d4)
                                  )
                              ),
                              Text(
                                  i["score2"],
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFd4d4d4)
                                  )
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text(i["timeCompleted"], style: const TextStyle(fontSize: 10.0)),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                  );
                },
              );
            }).toList(),
          ),
          Expanded(child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  color: const Color(0xFF535c65),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(articleId: articles[index].id.toString(),),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.newspaper, color: Color(0xFFd4d4d4),),
                          title: Text(
                            articles[index].title,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFd4d4d4),
                                color: Color(0xFFd4d4d4)
                            ),
                          ),
                          subtitle: Text(
                            articles[index].description,
                            style: const TextStyle(color: Color(0xFFd4d4d4)),
                          ),
                        )
                      ],
                    ),
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
    fetchCompletedMatches().then((value) {
      setState(() {
        matches = value;
      });
    });
    fetchNews().then((value) {
      setState(() {
        articles = value;
      });
    });
  }
}