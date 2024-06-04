import 'package:big_fun_app/models/attendees.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AttendeesDetails extends StatefulWidget {
  const AttendeesDetails({required this.attendee, super.key});
  final Attendees attendee;

  @override
  State<AttendeesDetails> createState() => _AttendeesDetailsState(this.attendee);
}

class _AttendeesDetailsState extends State<AttendeesDetails> {
  _AttendeesDetailsState(this.attendee);
  final Attendees attendee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${attendee.name}".toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 20),),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sentiment_dissatisfied, size: 24, color: Color(0xff63633A3),),
              Text("NOT YET", style: TextStyle(color: Color(0xff63633A3), fontSize: 16, letterSpacing: 2, wordSpacing: 2))
            ],
          ),
        ],
      ),
    );
  }
}