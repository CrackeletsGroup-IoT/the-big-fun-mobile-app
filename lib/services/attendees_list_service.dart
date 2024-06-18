import 'dart:convert';
import 'dart:io';

import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:big_fun_app/models/attendeeByEvent.dart';
import 'package:http/http.dart' as http;

class AttendeesListService{
  static Future<List<EventAttendee>> getAttendeesByEvent(int eventId) async{
    http.Response rspta = await http.get(Uri.parse("https://the-big-fun.zeabur.app/api/v1/event-attendees/events/${eventId}?page=0&size=1&sort=string"));
    if(rspta.statusCode == HttpStatus.ok){
      final jsonResponde = json.decode(rspta.body);
      print(jsonResponde);
      final List maps = jsonResponde['content'];
      final attendees = maps.map(
          (e) => 
            EventAttendee.fromJson(e)
        ).toList();

      return attendees;
    }

    return [];
  }
}