import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

var matchList = [];
var matchFavList = [];
var favTourny = ["Korea", "EMEA"];
final dio = Dio();

fetchNews() async {
  final response = await dio.get('https://vlrggapi.vercel.app/news');
  var articles = [];
  if (response.statusCode == 200) {
    articles = response.data['data']['segments'];
    for (var article in articles) {
      var id = article['url_path'].split('/')[3];
      article['id'] = id;
    }
    return articles;
  } else {
    throw Exception('Failed to load article');
  }
}

fetchCompletedMatches() async {
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=results');
  if (response.statusCode == 200) {
    var matches = response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      if (!matches[i]['time_completed'].toString().contains('1d')) {
        matches[i]['category'] = 0;
        if(matchIsFavorite(matches[i])){
          matchFavList.add(matches[i]);
          return matchFavList;
        }
        matchList.add(matches[i]);
      } else {
        return matchList;
      }
    }
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchUpcomingMatches() async {
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=upcoming');
  var matches = [];
  if (response.statusCode == 200) {
    matches += response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 1;
      if(matchIsFavorite(matches[i])){
        matchFavList.add(matches[i]);
        return matchFavList;
      }
      matchList.add(matches[i]);
    }
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchLiveMatches() async {
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=live_score');
  var matches = [];
  if (response.statusCode == 200) {
    matches += response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 2;
      if(matchIsFavorite(matches[i])){
        matchFavList.add(matches[i]);
        return matchFavList;
      }
      matchList.add(matches[i]);
    }
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchArticles(var articleId) async {
  final dio = Dio();
  final response = await dio.get('http://0.0.0.0:3001/article/$articleId');
  var text = '';
  if (response.statusCode == 200) {
    text = response.data['data']['segments'][0]['text'];
  }
  return text;
}

countryToFlag(var country){
  switch(country){
    case 'flag_in':
      return '🇮🇳';
    case 'flag_cn':
      return '🇨🇳';
    case 'flag_au':
      return '🇦🇺';
    case 'flag_jp':
      return '🇯🇵';
    case 'flag_mx':
      return '🇲🇽';
    case 'flag_cl':
      return '🇨🇱';
    case 'flag_un':
      return '🇺🇳';
    case 'flag_br':
      return '🇧🇷';
    case 'flag_eu':
      return '🇪🇺';
    case 'flag_tr':
      return '🇹🇷';
    case 'flag_bd':
      return '🇧🇩';
    case 'flag_ar':
      return '🇦🇷';
    case 'flag_id':
      return '🇮🇩';
    case 'flag_sg':
      return '🇸🇬';
    case 'flag_ph':
      return '🇵🇭';
    case 'flag_th':
      return '🇹🇭';
    case 'flag_ca':
      return '🇨🇦';
    case 'flag_ec':
      return '🇪🇨';
    case 'flag_co':
      return '🇨🇴';
    case 'flag_kr':
      return '🇰🇷';
    case 'flag_us':
      return '🇺🇸';
    case 'flag_gb':
      return '🇬🇧';
    case 'flag_de':
      return '🇩🇪';
    case 'flag_fr':
      return '🇫🇷';
    case 'flag_my':
      return '🇲🇾';
    case 'flag_tw':
      return '🇹🇼';
    case 'flag_mn':
      return '🇲🇳';
    case 'flag_vn':
      return '🇻🇳';
  }
}

matchIsFavorite(var match){
  int score = 0;
  String tournament = "";
  if (match['tournament_name'] == null) {
    tournament = match['match_event'];
  }
  else {
    tournament = match['tournament_name'];
  }
  for (String favorite in favTourny){
    if(tournament.contains(favorite)){
      score++;
    }
  }
  if (score > 0){
    return true;
  }
  return false;
}