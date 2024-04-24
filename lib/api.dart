import 'package:http/http.dart' as http;
import 'Models/Article.dart';
import 'dart:async';

Future<List<Article>> fetchNews() async {
  final response = await http.get(Uri.parse('https://vlrggapi.vercel.app/news'));
  List<String> test = response.body.split('[')[1].split(']')[0].split('{');
  List<Article> articles = [];
  if (response.statusCode == 200) {

    for (var i = 1; i < test.length; i++) {
      var asdasd = test[i];
      var asd = asdasd.split('"title":"');
      var title = asd[1].split('","description":"')[0];
      var description = asd[1].split('","description":"')[1].split('","date":"')[0];
      var date = asd[1].split('","description":"')[1].split('","date":"')[1].split('","author":"')[0];
      var author = asd[1].split('","description":"')[1].split('","date":"')[1].split('","author":"')[1].split('","url_path":"')[0];
      var urlPath = asd[1].split('","description":"')[1].split('","date":"')[1].split('","author":"')[1].split('","url_path":"')[1].split('"}')[0];
      Article article = Article(title: title, description: description, date: date, author: author, urlPath: urlPath);
      articles.add(article);
    }
    return articles;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load article');
  }
}