import 'package:vlr/app/rocket_league/models/account.dart';
import 'package:vlr/app/rocket_league/models/team.dart';

class Player {
  final String id;
  final String slug;
  final String tag;
  final String name;
  final String country;
  final Team team;
  final List<Account> accounts;
  final bool substitute;

  Player({
    required this.id,
    required this.slug,
    required this.tag,
    required this.name,
    required this.country,
    required this.team,
    required this.accounts,
    required this.substitute,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    var team = Team.fromJson(json['team']);
    var accountList = json['accounts'] as List;
    List<Account> accountsList = accountList.map((i) => Account.fromJson(i)).toList();

    return Player(
      id: json['_id'],
      slug: json['slug'],
      tag: json['tag'],
      name: json['name'],
      country: json['country'],
      team: team,
      accounts: accountsList,
      substitute: json['substitute'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'tag': tag,
      'name': name,
      'country': country,
      'team': team.toJson(),
      'accounts': accounts.map((account) => account.toJson()).toList(),
      'substitute': substitute,
    };
  }
}