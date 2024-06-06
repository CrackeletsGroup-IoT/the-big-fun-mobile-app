import 'dart:convert';
import 'dart:io';

import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:http/http.dart' as http;
class UuidServiceProvider{
  static Future<IoTDevice?> getIoTDeviceByUuid(String uuid) async{
    http.Response rspta = await http.get(Uri.parse("https://the-big-fun.zeabur.app/api/v1/payments/uuid/${uuid}"));
    if(rspta.statusCode == HttpStatus.ok){
      final jsonResponde = json.decode(rspta.body);
      final iotDevice = IoTDevice.fromJson(jsonResponde['eventAttendee']['ioTDevice']);
      return iotDevice;
    }

    return null;
  }
}