import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/ioTDevice.dart';

class EventAttendee{
  int id;
  Attendees attendees;
  IoTDevice? iotDevice;

  EventAttendee({
    required this.id,
    required this.attendees,
    this.iotDevice
  });

  static EventAttendee fromJson(Map<String, dynamic> json){
    return EventAttendee(
      id: json['id'] as int,
      attendees: Attendees.fromJson(json['attendee']),
      iotDevice: json['ioTDevice'] != null ? IoTDevice.fromJson(json['ioTDevice']) : null
    );
  }
}