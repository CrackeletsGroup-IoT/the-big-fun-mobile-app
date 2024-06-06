import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrAttendee extends StatefulWidget {
  const ScanQrAttendee({super.key});

  @override
  State<ScanQrAttendee> createState() => _ScanQrAttendeeState();
}

class _ScanQrAttendeeState extends State<ScanQrAttendee> {
  @override
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
        onDetect: (code) {
          print(code);
          final List<Barcode> barcodes = code.barcodes;
          final Uint8List? image = code.image;
          for(final barcode in barcodes){
            print("ESTE ES EL VALOR: ${barcode.rawValue}");
          }
          Navigator.pop(context);
        },
      )
    );
  }
}
