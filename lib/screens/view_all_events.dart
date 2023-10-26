import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../services/event_service.dart';
import '../utils/functions.dart';


class ViewAllEvents extends StatefulWidget {

  const ViewAllEvents({super.key});

  @override
  State<ViewAllEvents> createState() => _ViewAllEventsState();
}

class _ViewAllEventsState extends State<ViewAllEvents> {

  //"_"-> indica que es privado
  EventService? _eventService;

  //para la paginacion
  final _pageSize=20;
  final PagingController<int,Event>_pagingController=PagingController(firstPageKey: 0);

  @override
  void initState(){
    //inicializa el servicio
    _eventService=EventService();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future _fetchPage(int pageKey) async {
    try {

      //trae todos los pokemons
      final events = await _eventService?.getAll(pageKey, _pageSize)??[];

      final isLastPage = events.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(events);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(events, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {

    Color color_background = Color(0xFF6363A3);

    return Scaffold(

      backgroundColor: color_background,

      appBar: AppBar(
        title: Text('Event List'),
        backgroundColor: color_background, // Cambia el color del AppBar aquí
        centerTitle: true, // Centra el texto en el AppBar
      ),

      body: Container(
        color: color_background, // Color de fondo
        child: PagedListView<int,Event>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Event>(
            itemBuilder: (context,item,index)=>EventItem(event: item),
          ),
        ),
      ),
    );

  }

  @override
  void dispose(){
    _pagingController.dispose();
    super.dispose();
  }
}

class EventItem extends StatefulWidget {
  const EventItem({super.key,required this.event});

  //parametros
  final Event? event;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {

  @override
  Widget build(BuildContext context) {

    //definir la imagen antes de añadirla en el card
    final event=widget.event;
    final image = getImageEvent(widget.event?.image??"");  //llama al metodo de FUNCTIONS

    Color color_button = Colors.black;
    Color color_text_button = Colors.white;
    Color card_color = Colors.white;
    Color color_text_title = Color(0xFF035397);
    Color color_text = Colors.black;


    return Card(
      elevation: 2,
      color: card_color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Ajusta el radio según tus necesidades
      ),

      child: ListTile(

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8), // Espacio entre el título y la siguiente fila
            Align(
              alignment: Alignment.center,
              child: Text(event?.name ?? "",
                style: TextStyle(
                  color: color_text_title,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8), // Espacio entre el título y la siguiente fila

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: image, // Reemplaza con la URL de tu imagen
                        height: 100,
                        width: 100,// Ajusta la altura según tus necesidades
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date :", style: TextStyle(color: color_text_title)),
                      Text("Cost   :", style: TextStyle(color: color_text_title)),
                      Text("Address :", style: TextStyle(color: color_text_title)),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        DateFormat('yyyy-MM-dd').format(event?.date ?? DateTime.now()),
                        style: TextStyle(color: color_text),
                      ),

                      Text('S/${event?.cost.toString() ?? ""}',style: TextStyle(color: color_text)),

                      Tooltip(
                        message: event?.address ?? "",
                        child: Text(
                          event?.address ?? "",
                          style: TextStyle(color: color_text),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Define lo que hace el botón "Details"
                },
                style: ElevatedButton.styleFrom(
                  primary: color_button,
                ),
                child: Text(
                  "Details",
                  style: TextStyle(
                    color: color_text_button,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



