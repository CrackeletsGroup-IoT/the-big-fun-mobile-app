import 'dart:convert';
import 'dart:io';

import 'package:big_fun_app/models/event.dart';
import 'package:http/http.dart' as http;

class OrganizerEventService{
  static Future<List<Event>> getEvent() async{
    String baseUrl = "https://the-big-fun.zeabur.app/api/v1/events/organizer/1?page=0&size=1&sort=string";
    http.Response rspta = await http.get(
        Uri.parse(baseUrl));
    if(rspta.statusCode==HttpStatus.ok) {

      final jsonResponse = json.decode(rspta.body);
      final List maps = jsonResponse['content'];
      final events = maps.map((e)=>Event.fromJson(e)).toList();
      return events;
    }
    return [];
  }
}