import 'dart:developer';

import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/repositories/event_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class FavoritesMeal extends StatefulWidget {
  const FavoritesMeal({super.key});

  @override
  State<FavoritesMeal> createState() => _FavoritesMealState();
}

class _FavoritesMealState extends State<FavoritesMeal> {

  EventRepository? _eventRepository;
  List<Event>? _favoriteEvents;

  initialize() async {
    _favoriteEvents = await _eventRepository?.getAll() ?? []; // se usa elvis por si retorna null
    log(_favoriteEvents.toString());
    setState(() {
      _favoriteEvents = _favoriteEvents;
    });
  }

  @override
  void initState() {
    _eventRepository=MealRepository();
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Favorite Meals'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home(),));
          },
        ),
      ),
      body: GridView.builder(
        itemCount: _favoriteMeals?.length??0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {

          return GestureDetector(

            onTap: () {
              final id = _favoriteMeals?[index].id ??'0';
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                return MealItem(mealId: id,);
              },)
              );
            },

            child: Card(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: NetworkImage(_favoriteMeals?[index].imageUrl??''),height: 130),
                const SizedBox(height: 10,),
                Text(_favoriteMeals?[index].name??'empty'),
              ],
            )),
          );
        },
      ),

    );
  }
}
