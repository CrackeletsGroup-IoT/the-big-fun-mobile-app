import 'package:flutter/cupertino.dart';

//obtene un evento por id
String getIdEvent(String url){
  https://the-big-fun-402823.rj.r.appspot.com/api/v1/events/1
  String id= RegExp(r'https://the-big-fun-402823.rj.r.appspot.com/api/v1/events/([^]*?)/')
      .firstMatch(url)?[1] as String;
  return id;
}

//obtener la imagen de un evento
ImageProvider getImageEvent(String imagen){
  NetworkImage networkImage= NetworkImage(imagen);
  return networkImage;
}