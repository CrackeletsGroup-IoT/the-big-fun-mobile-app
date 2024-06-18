import 'dart:typed_data';

import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:big_fun_app/screens/attendees_list.dart';
import 'package:big_fun_app/services/uuid_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrAttendee extends StatefulWidget {
  const ScanQrAttendee({super.key});

  @override
  State<ScanQrAttendee> createState() => _ScanQrAttendeeState();
}

class _ScanQrAttendeeState extends State<ScanQrAttendee> {
  @override

  TextEditingController _controller = TextEditingController();
  bool isScanComplete = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: MobileScanner(
        controller: 
          MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
          ),
        onDetect: (code) async {
          if(!isScanComplete){
            print(code);
          final List<Barcode> barcodes = code.barcodes;
          final Uint8List? image = code.image;
          for(final barcode in barcodes){
            print("ESTE ES EL VALOR: ${barcode.rawValue}");
          }
          if (barcodes.length == 1) {
            final String? rawValue = barcodes[0].rawValue;
            if (rawValue!= null) {
              print("UUID encontrado: " + rawValue);
              final EventAttendee? rspta = await UuidServiceProvider.getEventAttendeeByUuid(rawValue);
              if (rspta != null){
                print("Se ha encontrado el asistente");
                openDialogint(rspta);
              }
            }
          }}else{
            Navigator.pop(context);
          }
        },
      )
    );
  }

  openDialogint(EventAttendee eventAttendee){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(16),
          children: [
            Text("Agrega el dispositivo IoT para ${eventAttendee.attendees.name}"),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "ID de dispositivo IoT",
              ),
              onChanged: (value) {
                print(value);
              }),
              FilledButton(onPressed: () {
                print("Listo para entregar");
                final rspta = UuidServiceProvider.addIoTDeviceToEventAttendee(eventAttendee.id, int.parse(_controller.text));
                if (rspta != null){
                  print("Se ha añadido el dispositivo IoT");
                  isScanComplete = true;
                  Navigator.pop(context);
                }
                else{
                  print("No se ha añadido el dispositivo IoT");
                }
              }, child: Text("Añadir")),
              FilledButton(onPressed: (){
                isScanComplete = true;
                Navigator.pop(context);
                }, child: Text("Cancelar")
            )
          ],
        );
      }
    );
  }
}

