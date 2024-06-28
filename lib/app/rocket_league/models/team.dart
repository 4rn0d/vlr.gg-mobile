import 'package:vlr/app/rocket_league/models/player.dart';

class Team {
  final String id;
  final String slug;
  final String name;
  final String region;
  final String image;
  final List<Player> players;

  Team({
    required this.id,
    required this.slug,
    required this.name,
    required this.region,
    required this.image,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var playerList = json['players'] as List;
    List<Player> playersList = playerList.map((i) => Player.fromJson(i)).toList();

    return Team(
      id: json['_id'],
      slug: json['slug'],
      name: json['name'],
      region: json['region'],
      image: json['image'],
      players: playersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'name': name,
      'region': region,
      'image': image,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}