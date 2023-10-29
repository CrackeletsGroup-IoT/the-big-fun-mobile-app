import 'dart:convert';
import 'dart:io';                               //importar .io
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventService{

  final baseUrl="https://the-big-fun-402823.rj.r.appspot.com/api/v1/events";

  //devuelve en algun momento una lista
  Future<List<Event>?> getAll(int page, int size) async{

    http.Response response=await http.get(Uri
        .parse("$baseUrl?offset=${page*size}&limit=$size"));

    //si la respuesta devuelve algo
    if(response.statusCode==HttpStatus.ok){

      //es la respuesta de tod el json
      final jsonResponse=json.decode(response.body);

      final List maps=jsonResponse["content"];

      //cada map es asignado a un objeto Pokemon usando su metodo de fromJson
      //crea una lista de event
      final events = maps.map((e) => Event.fromJson(e)).toList();

      return events;
    }
    return [];
  }

}


