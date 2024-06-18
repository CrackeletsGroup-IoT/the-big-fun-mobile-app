import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/ioTDevice.dart';

class AttendeeByEvent{
  Attendees attendees;
  IoTDevice? iotDevice;

  AttendeeByEvent({
    required this.attendees,
    this.iotDevice
  });

  static AttendeeByEvent fromJson(Map<String, dynamic> json){
    return AttendeeByEvent(
      attendees: Attendees.fromJson(json['attendee']),
      iotDevice: json['ioTDevice'] != null ? IoTDevice.fromJson(json['ioTDevice']) : null
    );
  }
}