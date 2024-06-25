import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/attendeeByEvent.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/models/eventAttendee.dart';
import 'package:big_fun_app/screens/attendees_details.dart';
import 'package:big_fun_app/services/attendees_list_service.dart';
import 'package:big_fun_app/screens/scan_qr_attendee.dart';
import 'package:big_fun_app/services/uuid_service.dart';
import 'package:flutter/material.dart';

List<String> status = ["NO PRESENTE", "PRESENTE", "NO PRESENTE"];
class AttendeesList extends StatefulWidget {
  const AttendeesList({required this.event, super.key});
  final Event event;

  @override
  State<AttendeesList> createState() => _AttendeesListState(event);
}

class _AttendeesListState extends State<AttendeesList> {
  _AttendeesListState(this.event);
  final Event event;
  late Future<List<EventAttendee>> _attendeesFuture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _attendeesFuture = AttendeesListService.getAttendeesByEvent(event.id);
  }

  Future<void> _refreshAttendees() async {
    setState(() {
      _attendeesFuture = AttendeesListService.getAttendeesByEvent(event.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshAttendees,
          color: Colors.white,
          backgroundColor: Color(0xff6363A3),
          child: FutureBuilder<List<EventAttendee>>(
            initialData: [],
            future: _attendeesFuture,
            builder: (BuildContext context, AsyncSnapshot<List<EventAttendee>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              "PARTICIPANTES",
                              style: TextStyle(
                                color: Color(0xff6363A3),
                                letterSpacing: 2,
                                wordSpacing: 2,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanQrAttendee(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    } else {
                      EventAttendee attendee = snapshot.data![index - 1];
                      
                      return Dismissible(
                        key: Key(attendee.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) async {
                          setState(() {
                            isLoading = true; // Mostrar el indicador de progreso
                          });
                          
                          await UuidServiceProvider.deleteIoTDeviceToEventAttendee(attendee.id);
                          setState(() {
                            isLoading = false; // Ocultar el indicador de progreso
                          });
                          _refreshAttendees();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttendeesDetails(
                                    attendee: attendee,
                                    ioTDevice: attendee.iotDevice,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF6F6F6),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${attendee.attendees.name}".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        wordSpacing: 4,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width / 3,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: attendee.iotDevice != null
                                            ? Color(0xffBBFFBF)
                                            : Color(0xffFFC0C0),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        border: Border.all(
                                          width: 2,
                                          color: attendee.iotDevice != null
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          attendee.iotDevice != null ? "PRESENTE" : "NO PRESENTE",
                                          style: TextStyle(
                                            color: attendee.iotDevice != null
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}