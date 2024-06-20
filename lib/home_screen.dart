import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vlr/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    matchList = [];
    matchFavList = [];
    fetchCompletedMatches();
    fetchLiveMatches();
    fetchUpcomingMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: matchFavList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                              Text(countryToFlag(matchFavList[index]['flag1']),
                                  style: const TextStyle(fontSize: 16.0)),
                              Text(countryToFlag(matchFavList[index]['flag2']),
                                  style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 210.0,
                                child: Text(matchFavList[index]["team1"],
                                  style: const TextStyle(fontSize: 14.0),),
                              ),
                              SizedBox(
                                width: 210.0,
                                child: Text(matchFavList[index]["team2"],
                                    style: const TextStyle(fontSize: 14.0)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (matchFavList[index]['category'] == 0)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                matchFavList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                matchFavList[index]["score2"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                          ],
                        ),
                      if (matchFavList[index]['category'] == 1)
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
                      if (matchFavList[index]['category'] == 2)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                matchFavList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                matchFavList[index]["score2"],
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
                          if (matchFavList[index]['category'] == 0)
                            Text(matchFavList[index]["time_completed"]
                                .toString()
                                .replaceAll('ago', ''),
                                style: const TextStyle(fontSize: 10.0)),
                          if (matchFavList[index]['category'] == 1)
                            Text(matchFavList[index]["time_until_match"]
                                .toString()
                                .replaceAll('from now', ''),
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.green)),
                          if (matchFavList[index]['category'] == 2)
                            Text(matchFavList[index]["time_until_match"]
                                .toString()
                                .replaceAll('from now', ''),
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.red)),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
                );
              }
            ),
          )
        ],
      ),
    );
  }
}