import 'package:vlr/app/valorant/Services/valorant_service.dart' as service;
class Event {
  final String id;
  final String name;
  final String status;
  final String prizepool;
  final String dates;
  final String country;
  final String img;

  bool get isFavorite {
    return service.isFavorite(name);
  }

  String get league {
    return service.eventToLeague(this);
  }

  Event({
    required this.id,
    required this.name,
    required this.status,
    required this.prizepool,
    required this.dates,
    required this.country,
    required this.img,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      prizepool: json['prizepool'],
      dates: json['dates'],
      country: json['country'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'prizepool': prizepool,
      'dates': dates,
      'country': country,
      'img': img,
    };
  }
}

