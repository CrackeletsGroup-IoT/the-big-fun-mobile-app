import 'package:big_fun_app/repositories/event_repository.dart';
import 'package:big_fun_app/services/event_service.dart';
import 'package:flutter/material.dart';

import 'package:big_fun_app/screens/view_events_with_detail.dart';
import 'package:big_fun_app/screens/view_purchase_tickets.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../utils/functions.dart';


class MyEventItem extends StatefulWidget {

  final Event event;

  const MyEventItem({super.key, required this.event});

  @override
  State<MyEventItem> createState() => _MyEventItemState();
}

class _MyEventItemState extends State<MyEventItem> {


  bool _favorite=false;
  EventRepository? _repository;

  initialize() async {
    _favorite = await _repository?.isFavorite(widget.event)??false;
    if(mounted){
      setState(() {
        _favorite = _favorite;
      });
    }
  }

  @override
  void initState() {
    _repository=EventRepository();
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    //definir la imagen antes de añadirla en el card
    final event=widget.event;
    final image = getImageEvent(widget.event?.image??"");  //llama al metodo de FUNCTIONS

    Color colorButton = Colors.black;
    Color colorTextButton = Colors.white;
    Color cardColor = Colors.white;
    Color colorTextTitle = const Color(0xFF035397);
    Color colorText = Colors.black;


    return Card(
      elevation: 2,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Ajusta el radio según tus necesidades
      ),

      child: ListTile(

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8), // Espacio entre el título y la siguiente fila
            Align(
              alignment: Alignment.center,
              child: Text(event?.name ?? "",
                style: TextStyle(
                  color: colorTextTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 18), // Espacio entre el título y la siguiente fila

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: image, // Reemplaza con la URL de tu imagen
                        height: 200,
                        width: 300,// Ajusta la altura según tus necesidades
                      ),
                    ],
                  ),


                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewEventsWithDetail(eventId: (event?.id).toString())));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorButton,
                      ),
                      child: Text(
                        "Details",
                        style: TextStyle(
                          color: colorTextButton,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {

                    },
                  )
                ],
              ),
            ),
            const SizedBox(width: 40),

          ],
        ),
      ),
    );
  }
}
