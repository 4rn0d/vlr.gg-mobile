import 'package:vlr/app/rocket_league/models/stage.dart';

class Event {
  final String id;
  final String slug;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String region;
  final int mode;
  final Map<String, dynamic> prize;
  final String tier;
  final String image;
  final List<String> groups;
  final List<Stage> stages;

  Event({
    required this.id,
    required this.slug,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.region,
    required this.mode,
    required this.prize,
    required this.tier,
    required this.image,
    required this.groups,
    required this.stages,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var groupList = json['groups'] as List;
    List<String> groupsList = groupList.cast<String>();

    var stageList = json['stages'] as List;
    List<Stage> stagesList = stageList.map((i) => Stage.fromJson(i)).toList();

    return Event(
      id: json['_id'],
      slug: json['slug'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      region: json['region'],
      mode: json['mode'],
      prize: json['prize'],
      tier: json['tier'],
      image: json['image'],
      groups: groupsList,
      stages: stagesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'region': region,
      'mode': mode,
      'prize': prize,
      'tier': tier,
      'image': image,
      'groups': groups,
      'stages': stages.map((stage) => stage.toJson()).toList(),
    };
  }
}