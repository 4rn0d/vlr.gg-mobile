import 'package:flutter/material.dart';
import 'package:vlr/article_screen.dart';
import 'package:vlr/service.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  var articles = [];

  @override
  void initState() {
    super.initState();
    toListAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (context, index) {
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
    );
  }
  Future<void> toListAsync() async {
    fetchNews().then((value) {
      setState(() {
        articles = value;
      });
    });
  }
}
