import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../services/event_service.dart';
import '../utils/functions.dart';


class ViewAllEvents extends StatefulWidget {

  const ViewAllEvents({super.key});

  static const name = 'events-screen';

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

    Color colorBackground = const Color(0xFF6363A3);

    return Scaffold(

      backgroundColor: colorBackground,

      appBar: AppBar(
        title: const Text('Event List '),
        backgroundColor: colorBackground, // Cambia el color del AppBar aquí
        centerTitle: true, // Centra el texto en el AppBar
      ),

      body: Container(
        color: colorBackground, // Color de fondo
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
            const SizedBox(height: 8), // Espacio entre el título y la siguiente fila

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
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date :", style: TextStyle(color: colorTextTitle)),
                      Text("Cost   :", style: TextStyle(color: colorTextTitle)),
                      Text("Address :", style: TextStyle(color: colorTextTitle)),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        DateFormat('yyyy-MM-dd').format(event?.date ?? DateTime.now()),
                        style: TextStyle(color: colorText),
                      ),

                      Text('S/${event?.cost.toString() ?? ""}',style: TextStyle(color: colorText)),

                      Tooltip(
                        message: event?.address ?? "",
                        child: Text(
                          event?.address ?? "",
                          style: TextStyle(color: colorText),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                          .go('/attendants/events/${event?.id}');
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
          ],
        ),
      ),
    );
  }
}



