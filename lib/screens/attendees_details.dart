import 'dart:async';
import 'dart:convert';
import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/models/ioTDevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AttendeesDetails extends StatefulWidget {
  const AttendeesDetails({required this.attendee, required this.ioTDevice, super.key});
  final EventAttendee attendee;
  final IoTDevice? ioTDevice;

  @override
  State<AttendeesDetails> createState() => _AttendeesDetailsState(this.attendee, this.ioTDevice);
}

class _AttendeesDetailsState extends State<AttendeesDetails> {
  _AttendeesDetailsState(this.attendee, this.ioTDevice);
  final EventAttendee attendee;
  late Timer _timer;
  IoTDevice? ioTDevice;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-12.104026662911233, -76.962901676701);
  BitmapDescriptor YourLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor FriendLocationIcon = BitmapDescriptor.defaultMarker;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/profile_avatar.png").then((value) => YourLocationIcon = value);
  }

  @override
  void initState() {
    setCustomMarkerIcon();
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
  if (attendee.iotDevice != null) {
    final response = await http.get(Uri.parse('https://the-big-fun.zeabur.app/api/v1/iot-devices/iotDevice/${attendee.iotDevice?.id}'));
      if (response.statusCode == 200) {
        if (mounted) { // Verifica si el widget está montado antes de llamar a setState
          setState(() {
            final rspta = json.decode(response.body);
            ioTDevice = IoTDevice.fromJson(rspta);
          });
        }
      } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    //Scaffold cuando no haya ningun dispositivo IoT
    SafeArea(
      child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 12.0, left: 16.0, right: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/profile_avatar.png'),
                      fit: BoxFit.contain,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${attendee.attendees.name}", style: TextStyle(color: Color(0xFF6363A3), fontWeight: FontWeight.w700, fontSize: 36, letterSpacing: 2),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:   8.0, horizontal: 16.0),
                      child: Icon(Icons.email, color:Color(0xFF6363A3), size: 18 ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text("${attendee.attendees.email}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:   8.0, horizontal: 16.0),
                      child: Icon(Icons.person, color:Color(0xFF6363A3), size: 18 ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text("${attendee.attendees.userName}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFF6363A3)
                    ),
                  child: 
                  // DATOS DEL CONTAINER
                  attendee.iotDevice != null ?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Dispositivo IoT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 36, letterSpacing: 2),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.monitor_heart, color: Colors.white, size: 16,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pulso cardiaco", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${ioTDevice?.pulse}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
                          ),
                          
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ioTDevice?.safe == true ? Color(0xffBBFFBF) : Color(0xffFFC0C0),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                  width: 2,
                                  color: ioTDevice?.safe == true ? Colors.green : Colors.red
                                    )
                                  ),
                                child: Center(child: Text(ioTDevice?.safe == true  ? "SAFE" : "DANGER", style: TextStyle(color: ioTDevice?.safe == true? Colors.green : Colors.red))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: ioTDevice?.safe == true ?Colors.white.withOpacity(0.2) : Colors.white,
                                ),
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Icon(Icons.local_hospital, color: ioTDevice?.safe == true ?Colors.white.withOpacity(0.2) : Colors.white)
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.location_on, color: Colors.red, size: 16,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Tu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
                                  ),
                                ]
                              ),
                            ),
                            Expanded(
                              child: 
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("${ioTDevice?.distanceBetween} m", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),)),
                                ),
                              ),)
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.location_on, color: Colors.green, size: 16,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Amigo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                        height: MediaQuery.of(context).size.width,
                        //Google maps container
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 18.0
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId("1"),
                              position: LatLng(-12.104026662911233, -76.962901676701),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                            ),
                            Marker(
                              markerId: MarkerId("2"),
                              position: LatLng(-12.104510528382757, -76.96341800191995),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                            ),
                          }
                        )
                      ))
                    ],
                  ) :
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text("No existe dispositivo IoT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: 2),)),
                  )
                ),
              )
            ],
          ),
      ),
    );
  }
}