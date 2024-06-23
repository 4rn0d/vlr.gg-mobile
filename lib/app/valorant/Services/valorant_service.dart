import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';
import 'package:vlr/app/valorant/Models/event.dart';
import 'package:vlr/app/valorant/Models/team.dart';
import 'package:vlr/app/valorant/leagues.dart';

var matchList = [];
var matchFavList = [];
var favTourny = ["Challengers League Korea", "Champions Tour EMEA"];
var favTeams = [];
final dio = Dio();
bool isLoading = false;

fetchNews() async {
  isLoading = true;
  final response = await dio.get('https://vlrggapi.vercel.app/news');
  var articles = [];
  if (response.statusCode == 200) {
    articles = response.data['data']['segments'];
    for (var article in articles) {
      var id = article['url_path'].split('/')[3];
      article['id'] = id;
    }
    isLoading = false;
    return articles;
  } else {
    throw Exception('Failed to load article');
  }
}

fetchCompletedMatches() async {
  isLoading = true;
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=results');
  if (response.statusCode == 200) {
    var matches = response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      if (!matches[i]['time_completed'].toString().contains('1d')) {
        matches[i]['category'] = 0;
        if(isFavorite(matches[i]["tournament_name"])){
          matchFavList.add(matches[i]);
          isLoading = false;
          return matchFavList;
        }
        matchList.add(matches[i]);
      } else {
        isLoading = false;
        return matchList;
      }
    }
    isLoading = false;
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchUpcomingMatches() async {
  isLoading = true;
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=upcoming');
  var matches = [];
  if (response.statusCode == 200) {
    matches += response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 1;
      if(isFavorite(matches[i]["match_event"])){
        matchFavList.add(matches[i]);
        isLoading = false;
        return matchFavList;
      }
      matchList.add(matches[i]);
    }
    isLoading = false;
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchLiveMatches() async {
  isLoading = true;
  final response = await dio.get('https://vlrggapi.vercel.app/match?q=live_score');
  var matches = [];
  if (response.statusCode == 200) {
    matches += response.data['data']['segments'];
    for (int i = 0; i < matches.length; i++) {
      matches[i]['category'] = 2;
      if(isFavorite(matches[i]["match_event"])){
        matchFavList.add(matches[i]);
        isLoading = false;
        return matchFavList;
      }
      matchList.add(matches[i]);
    }
    isLoading = false;
    return matchList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load matches');
  }
}

fetchArticles(var articleId) async {
  isLoading = true;
  final dio = Dio();
  final response = await dio.get('http://0.0.0.0:3001/article/$articleId');
  var text = '';
  if (response.statusCode == 200) {
    text = response.data['data']['segments'][0]['text'];
  }
  isLoading = false;
  return text;
}

fetchEvents() async {
  isLoading = true;
  final dio = Dio();
  List<Event> tempEvents = [];
  for (int i = 1; i <= 4; i++){
    final response = await dio.get('https://vlr.orlandomm.net/api/v1/events?page=$i');
    if (response.statusCode == 200) {
      for (var event in response.data['data']){
        tempEvents.add(Event.fromJson(event));
      }
    }
  }
  List<Event> events = [];
  if (tempEvents.isNotEmpty) {
    for (var event in tempEvents){
      String eventName = event.name;

      if (eventName.contains('Champions Tour') || eventName.contains('Challengers League') || eventName.contains('Game Changers')){
        if (event.status != "completed"){
          eventToLeague(event);
          events.add(event);
        }
      }
    }
  }
  events.sort((a, b) => a.dates.compareTo(b.dates));
  events.sort((a, b) {
    if(b.isFavorite) {
      return 1;
    }
    return -1;
  });
  isLoading = false;
  return events;
}

fetchTeams() async {
  isLoading = true;
  var regions = ['na', 'eu', 'br', 'ap', 'kr', 'ch', 'jp', 'lan', 'las', 'oce', 'gc'];
  List<Team> teams = [];
  for (var region in regions){
    final response = await dio.get('https://vlr.orlandomm.net/api/v1/teams?limit=50&region=$region');
    if (response.statusCode == 200) {
      for (var team in response.data['data']){
        teams.add(Team.fromJson(team));
      }
    } else {
      throw Exception('Failed to load teams');
    }
  }
  isLoading = false;
  teams.sort((a, b) => a.name.compareTo(b.name));
  teams.sort((a, b) {
    if(b.isFavorite) {
      return 1;
    }
    return -1;
  });
  return teams;
}

fetchTeam(String id) async {
  isLoading = true;
  final response = await dio.get('https://vlr.orlandomm.net/api/v1/teams/$id');
  if (response.statusCode == 200) {
    isLoading = false;
    return Team.fromJson(response.data['data']);
  } else {
    throw Exception('Failed to load teams');
  }
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
    case 'flag_pt':
      return '🇵🇹';
    case 'flag_it':
      return '🇮🇹';
  }
}

isFavorite(String eventName){
  int score = 0;
  for (String favorite in favTourny){
    if(eventName.contains(favorite)){
      score++;
    }
  }
  if (score > 0){
    return true;
  }
  return false;
}

eventToLeague(Event event){
  String eventName = event.name;

  String leagueName = eventName.split(':')[0];
  var split = leagueName.split(' ');
  String league = "";
  for (String year in split){
    if (year.contains("20")){
      if (eventName.contains(": EMEA") || eventName.contains(": Americas") || eventName.contains(": Pacific") || eventName.contains(": China")){
        String region = eventName.split(':')[1].split(' ')[1];
          league += "$leagueName : $region";
          league = league.replaceAll("$year ", "");
      }
      else{
        league = leagueName.replaceAll("$year ", "");
      }
    }
    else if (!leagueName.contains("20")) {
      league = leagueName;
    }
  }
  return league;
}

teamIsFavorite(String id){
  int score = 0;
  for (String favorite in favTeams){
    if(id == favorite){
      score++;
    }
  }
  if (score > 0){
    return true;
  }
  return false;
}

Future<Color> getImagePalette (ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator = await PaletteGenerator
      .fromImageProvider(imageProvider);
  return paletteGenerator.dominantColor!.color;
}