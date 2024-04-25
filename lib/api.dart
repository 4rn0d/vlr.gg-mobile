import 'package:http/http.dart' as http;
import 'Models/article.dart';
import 'Models/match.dart';
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

Future<List<Match>> fetchMatches() async {
  final response = await http.get(Uri.parse('https://vlrggapi.vercel.app/match/results'));
  List<String> test = response.body.split('[')[1].split(']')[0].split('{');
  List<Match> matches = [];
  if (response.statusCode == 200) {

    for (var i = 1; i < test.length-35; i++) {
      var asdasd = test[i];
      var asd = asdasd.split('"team1":"');
      var team1 = asd[1].split('","team2":"')[0];
      var team2 = asd[1].split('","team2":"')[1].split('","score1":"')[0];
      var score1 = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[0];
      var score2 = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[0];
      var flag1 = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[0];
      var flag2 = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[0];
      var timeCompleted = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[1].split('","round_info":"')[0];
      var roundInfo = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[1].split('","round_info":"')[1].split('","tournament_name":"')[0];
      var tournamentName = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[1].split('","round_info":"')[1].split('","tournament_name":"')[1].split('","match_page":"')[0];
      var matchPage = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[1].split('","round_info":"')[1].split('","tournament_name":"')[1].split('","match_page":"')[1].split('","tournament_icon":"')[0];
      var tournamentIcon = asd[1].split('","team2":"')[1].split('","score1":"')[1].split('","score2":"')[1].split('","flag1":"')[1].split('","flag2":"')[1].split('","time_completed":"')[1].split('","round_info":"')[1].split('","tournament_name":"')[1].split('","match_page":"')[1].split('","tournament_icon":"')[1].split('"}')[0];

      Match match = Match(team1: team1, team2: team2, score1: score1, score2: score2, flag1: flag1, flag2: flag2, timeCompleted: timeCompleted, roundInfo: roundInfo, tournamentName: tournamentName, matchPage: matchPage, tournamentIcon: tournamentIcon);
      matches.add(match);
    }
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load article');
  }
}