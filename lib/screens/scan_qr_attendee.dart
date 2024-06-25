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
  TextEditingController _controller = TextEditingController();
  bool isScanComplete = false;
  late MobileScannerController _scannerController;
  bool ioTDeviceCreated = false;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(detectionSpeed: DetectionSpeed.normal);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: MobileScanner(
        controller: _scannerController,
        onDetect: (code) async {
          if (!isScanComplete) {
            isScanComplete = true;
            print(code);
            final List<Barcode> barcodes = code.barcodes;
            final Uint8List? image = code.image;
            for (final barcode in barcodes) {
              print("ESTE ES EL VALOR: ${barcode.rawValue}");
            }
            if (barcodes.length == 1) {
              final String? rawValue = barcodes[0].rawValue;
              if (rawValue != null) {
                print("UUID encontrado: " + rawValue);
                final EventAttendee? rspta = await UuidServiceProvider.getEventAttendeeByUuid(rawValue);
                if (rspta != null) {
                  print("Se ha encontrado el asistente");
                  openDialogint(rspta);
                } else {
                  isScanComplete = false;
                }
              } else {
                isScanComplete = false;
              }
            } else {
              isScanComplete = false;
            }
          }
        },
      ),
    );
  }

  void openDialogint(EventAttendee eventAttendee) {
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
              },
            ),
            FilledButton(
              onPressed: () async {
                print("Listo para entregar");
                final rspta = await UuidServiceProvider.addIoTDeviceToEventAttendee(eventAttendee.id, int.parse(_controller.text));
                print(rspta);
                if (rspta != null) {
                  print("Se ha añadido el dispositivo IoT");
                  _resetScanState();
                  Navigator.pop(context); // Cierra el diálogo
                  _showCreatedMessageDialog();
                } else {
                  print("No se ha añadido el dispositivo IoT");
                  _showFailMessageDialog();
                }
              },
              child: Text("Añadir"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                _resetScanState();
              },
              child: Text("Cancelar"),
            )
          ],
        );
      },
    );
  }

  void _showCreatedMessageDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle),
                  Text("El dispositivo IoT ha sido creado con éxito"),
                  FilledButton(
                    child: Text("Continuar"),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo
                      _resetScanState();
                    }
                  )
                ]
              ),
            ),
          )
        );
      },
    );
  }

  void _showFailMessageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error),
                  Text("No se ha podido añadir el dispositivo IoT"),
                  FilledButton(
                    child: Text("Reintentar"),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo
                    }
                  ),
                ]
              ),
            ),
          )
        );
      },
    );
  }



  void _resetScanState() {
    setState(() {
      isScanComplete = false;
      _controller.clear();
    });
  }
}