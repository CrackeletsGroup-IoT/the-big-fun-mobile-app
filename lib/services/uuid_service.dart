import 'dart:convert';
import 'dart:io';
import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:http/http.dart' as http;
class UuidServiceProvider{
  static Future<EventAttendee?> getEventAttendeeByUuid(String uuid) async{
    final rspta = await http.get(Uri.parse("https://the-big-fun.zeabur.app/api/v1/payments/uuid/${uuid}"));
    if(rspta.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(rspta.body);
      return EventAttendee.fromJson(jsonResponse['eventAttendee']);
    }
    return null;
  }

  static Future<EventAttendee?> addIoTDeviceToEventAttendee(int eventAttendee_id, int ioTDevice_id) async{
    final rspta = await http.put(Uri.parse("https://the-big-fun.zeabur.app/api/v1/event-attendees/${eventAttendee_id}/iot-device/${ioTDevice_id}"));
    if(rspta.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(rspta.body);
      return EventAttendee.fromJson(jsonResponse['eventAttendee']);
    }
    return null;
  }
    //delete
  static Future<EventAttendee?> deleteIoTDeviceToEventAttendee(int eventAttendee_id, int ioTDevice_id) async{
    final rspta = await http.delete(Uri.parse("https://the-big-fun.zeabur.app/api/v1/event-attendees/${eventAttendee_id}/iot-device/${ioTDevice_id}"));
    if(rspta.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(rspta.body);
      return EventAttendee.fromJson(jsonResponse);
    }  
  }
}