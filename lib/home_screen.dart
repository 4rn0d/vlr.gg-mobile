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
    fetchUpcomingMatches();
    fetchCompletedMatches();
    fetchLiveMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: matchList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Color(0xFF535c65),
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
                              Text(countryToFlag(matchList[index]['flag1']),
                                  style: const TextStyle(fontSize: 16.0)),
                              Text(countryToFlag(matchList[index]['flag2']),
                                  style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 210.0,
                                child: Text(matchList[index]["team1"],
                                  style: const TextStyle(fontSize: 14.0),),
                              ),
                              SizedBox(
                                width: 210.0,
                                child: Text(matchList[index]["team2"],
                                    style: const TextStyle(fontSize: 14.0)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (matchList[index]['category'] == 0)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                matchList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                matchList[index]["score2"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                          ],
                        ),
                      if (matchList[index]['category'] == 1)
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
                      if (matchList[index]['category'] == 2)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                matchList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                matchList[index]["score2"],
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
                          if (matchList[index]['category'] == 0)
                            Text(matchList[index]["time_completed"]
                                .toString()
                                .replaceAll('ago', ''),
                                style: const TextStyle(fontSize: 10.0)),
                          if (matchList[index]['category'] == 1)
                            Text(matchList[index]["time_until_match"]
                                .toString()
                                .replaceAll('from now', ''),
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.green)),
                          if (matchList[index]['category'] == 2)
                            Text(matchList[index]["time_until_match"]
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