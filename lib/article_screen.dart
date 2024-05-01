import 'dart:html';

import 'package:vlr/api.dart';

import 'tiroir_nav.dart';
import 'package:flutter/material.dart';

// TODO Un ecran qui peut accepter un parametre
class ArticleScreen extends StatefulWidget {

  final String articleId;

  const ArticleScreen({Key? key, required this.articleId}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();

}

class _ArticleScreenState extends State<ArticleScreen> {

  @override
  void initState() {
    fetchArticles(widget.articleId).then((value) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2f3337),
        title: const Text('Ecran B', style: TextStyle(color: Color(0xFFd4d4d4)),)
      ),
      body: Text('Tu as navigué vers B ave'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO quand on pop, on revient à l'écran précédent
          // ca enleve un ecran de la pile de navigation
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
