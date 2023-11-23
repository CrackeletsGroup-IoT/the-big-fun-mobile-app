import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/event.dart';
import '../services/event_service.dart';
import '../utils/my_event_item.dart';
import '../utils/navigation_drawer.dart';

class Home extends StatefulWidget {

  static const name = 'events-screen';

  Home({super.key,});

  final searchController= TextEditingController();
  final bool obscureText=false;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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

  toAllEvents(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllEvents(),));
  }

  @override
  Widget build(BuildContext context) {

    Color colorBackground = const Color(0xFF6363A3);

    return Scaffold(

      backgroundColor: colorBackground,

      appBar: AppBar(
        title: Center(child: Text("Popular Events")),
        backgroundColor: colorBackground, // Cambia el color del AppBar aquí
      ),
      drawer: const Navigation(),
      body: Container(
        color: colorBackground, // Color de fondo
        child: PagedListView<int,Event>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Event>(
            itemBuilder: (context,item,index)=>MyEventItem(event: item),
          ),
        ),
      ),

    );
  }
}
