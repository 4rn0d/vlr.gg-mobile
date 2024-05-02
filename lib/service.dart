import 'dart:convert';
import 'package:http/http.dart' as http;

fetchNews() async {
  final response =
      await http.get(Uri.parse('https://vlrggapi.vercel.app/news'));
  var articles = [];
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    articles = jsonResponse['data']['segments'];
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
  final response =
      await http.get(Uri.parse('https://vlrggapi.vercel.app/match?q=results'));
  var matches = [];
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    var matchesList = jsonResponse['data']['segments'];
    for (int i = 0; i < matchesList.length; i++) {
      if (!matchesList[i]['time_completed'].toString().contains('1d')) {
        matchesList[i]['category'] = 0;
        matches.add(matchesList[i]);
      } else {
        return matches;
      }
    }
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchUpcommingMatches() async {
  final response =
      await http.get(Uri.parse('https://vlrggapi.vercel.app/match?q=upcoming'));
  var matches = [];
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    matches = jsonResponse['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 1;
    }
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchLiveMatches() async {
  final response =
      await http.get(Uri.parse('https://vlrggapi.vercel.app/match?q=live_score'));
  var matches = [];
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    matches = jsonResponse['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 2;
    }
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchArticles(var articleId) async {
  final response =
      await http.get(Uri.parse('http://0.0.0.0:3001/article/$articleId'));
  var text = '';
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    text = jsonResponse['data']['segments'][0]['text'];
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
  }
}