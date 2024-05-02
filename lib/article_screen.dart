import 'package:vlr/service.dart';
import 'tiroir_nav.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {

  final String id;
  final String title;
  final String author;
  final String date;

  const ArticleScreen({super.key, required this.id, required this.title, required this.author, required this.date});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();

}

class _ArticleScreenState extends State<ArticleScreen> {
  String articleText = '';

  @override
  void initState() {
    super.initState();
    initText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2f3337),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.title, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(widget.author),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(widget.date),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(articleText)
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 12.0)),
          ],
        ),
      ),
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

  initText() async {
    fetchArticles(widget.id).then((value) {
      setState(() {
        articleText = value;
      });
    });
  }
}
