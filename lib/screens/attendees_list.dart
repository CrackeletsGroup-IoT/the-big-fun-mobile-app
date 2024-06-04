import 'package:big_fun_app/models/attendees.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/screens/attendees_details.dart';
import 'package:big_fun_app/services/attendees_list_service.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("PARTICIPANTES", style: TextStyle(color: Color(0xff6363A3), letterSpacing: 2,
                                wordSpacing: 2, fontWeight: FontWeight.w700, fontSize: 18),),
              ),
              FutureBuilder(
                initialData: [],
                future: AttendeesListService.getAttendeesByEvent(event.id), 
                builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      Attendees attendee = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        child: GestureDetector(
                          onDoubleTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AttendeesDetails(attendee: attendee),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${attendee.name}".toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, wordSpacing: 4, letterSpacing: 2),),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: status[index] == "PRESENTE" ? Color(0xffBBFFBF) : Color(0xffFFC0C0),
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        width: 2,
                                        color: status[index] == "PRESENTE" ? Colors.green : Colors.red
                                      )
                                    ),
                                    child: Center(child: Text("${status[index]}", style: TextStyle(color: status[index] == "PRESENTE" ? Colors.green : Colors.red))),
                                  ),
                                ],
                              
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }
              )
            ],
          ),
        )
      ),
    );
  }
}