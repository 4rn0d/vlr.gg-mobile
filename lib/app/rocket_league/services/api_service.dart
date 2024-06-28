// https://zsr.octane.gg/events

import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/event.dart';

bool isLoading = false;


fetchEvents() async {
  isLoading = true;
  final response = await SingletonDio.getDio().get('https://zsr.octane.gg/events');
  var events = [];
  if (response.statusCode == 200) {
    var result = json.decode(response.data[events]);
    for(var event in json.decode(response.data['events'])) {
      events.add(Event.fromJson(event));
    }
    events += response.data;
    isLoading = false;
    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Events');
  }
}

class SingletonDio {

  static Dio getDio() {
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    return dio;
  }
}