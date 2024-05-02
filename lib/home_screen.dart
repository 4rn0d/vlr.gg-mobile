import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlr/service.dart';
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

  var articles = [];
  var matches = [];


  @override
  void initState() {
    super.initState();
    toListAsync();
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
                              const Padding(padding: EdgeInsets.only(left: 10.0)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(countryToFlag(i['flag1']), style: const TextStyle(fontSize: 16.0)),
                                  Text(countryToFlag(i['flag2']), style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 210.0,
                                    child: Text(i["team1"], style: const TextStyle(fontSize: 14.0),),
                                  ),
                                  SizedBox(
                                    width: 210.0,
                                    child: Text(i["team2"], style: const TextStyle(fontSize: 14.0)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (i['category'] == 0)
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
                          if (i['category'] == 1)
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                    )
                                ),
                                Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                    )
                                ),
                              ],
                            ),
                          if (i['category'] == 2)
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
                              if (i['category'] == 0)
                                Text(i["time_completed"].toString().replaceAll('ago', ''), style: const TextStyle(fontSize: 10.0)),
                              if (i['category'] == 1)
                                Text(i["time_until_match"].toString().replaceAll('from now', ''), style: const TextStyle(fontSize: 10.0, color: Colors.green)),
                              if (i['category'] == 2)
                                Text(i["time_until_match"].toString().replaceAll('from now', ''), style: const TextStyle(fontSize: 10.0, color: Colors.red)),
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
          const Padding(padding: EdgeInsets.only(top: 10.0)),
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
                          builder: (context) => ArticleScreen(
                            id: articles[index]['id'].toString(),
                            title: articles[index]['title'],
                            author: articles[index]['author'],
                            date: articles[index]['date'],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.newspaper, color: Color(0xFFd4d4d4),),
                          title: Text(
                            articles[index]['title'],
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFd4d4d4),
                                color: Color(0xFFd4d4d4)
                            ),
                          ),
                          subtitle: Text(
                            articles[index]['description'],
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
    fetchLiveMatches().then((value) {
      setState(() {
        matches = value;
      });
      fetchUpcommingMatches().then((value) {
        setState(() {
          matches += value;
        });
        fetchCompletedMatches().then((value) {
          setState(() {
            matches += value;
          });
        });
      });
    });

    fetchNews().then((value) {
      setState(() {
        articles = value;
      });
    });
  }
}