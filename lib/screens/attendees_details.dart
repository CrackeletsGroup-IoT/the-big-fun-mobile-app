import 'dart:async';
import 'dart:convert';

import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/models/attendeeByEvent.dart';
import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:big_fun_app/services/web_socket_service.dart';
import 'package:http/http.dart' as http;

class AttendeesDetails extends StatefulWidget {
  const AttendeesDetails({required this.attendee, super.key});
  final EventAttendee attendee;

  @override
  State<AttendeesDetails> createState() => _AttendeesDetailsState(this.attendee);
}

class _AttendeesDetailsState extends State<AttendeesDetails> {
  _AttendeesDetailsState(this.attendee);
  final EventAttendee attendee;
  late Timer _timer;
  late IoTDevice _iotDevice;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch initial data
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => _fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://the-big-fun.zeabur.app/api/v1/iot-devices/iotDevice/5'));
    if (response.statusCode == 200) {
      setState(() {
        final rspta = json.decode(response.body);
        _iotDevice = IoTDevice.fromJson(rspta);
      });
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivo IoT'),
      ),
      body: Center(
        child: attendee.iotDevice == null || _iotDevice == null
            ? Text('No hay nada')
            : Text('Datos del Dispositivo: ${_iotDevice.pulse}'),
      ),
    );
  }
}