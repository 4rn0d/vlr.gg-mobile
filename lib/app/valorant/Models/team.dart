import 'package:flutter/cupertino.dart';
import 'package:vlr/app/valorant/Services/valorant_service.dart' as service;
class Team {
  final String id;
  final String url;
  final String name;
  final String img;
  final String country;

  Team({
    required this.id,
    required this.url,
    required this.name,
    required this.img,
    required this.country,
  });

  bool get isFavorite {
    return service.teamIsFavorite(id);
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      img: json['img'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'img': img,
      'country': country,
    };
  }
}