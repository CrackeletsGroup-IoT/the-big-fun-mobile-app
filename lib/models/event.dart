
import 'dart:convert';

class Event{

  int id;
  String name;
  String address;
  int capacity;
  String image;
  DateTime date;
  int cost;
  String district;

  Event(
      { required this.id,
        required this.name,
        required this.address,
        required this.capacity,
        required this.image,
        required this.date,
        required this.cost,
        required this.district
      }
      );

  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'name':name,
      'address':address,
      'capacity':capacity,
      'image':image,
      'date':date,
      'cost':cost,
      'district':district,

    };
  }

  Event.fromMap(Map<String,dynamic>map):
        id=map['id'],
        name=map['name'],
        address=map['address'],
        capacity=map['capacity'],
        image=map['image'],
        date=map['date'],
        cost=map['cost'],
        district=map['district'];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      capacity: json["capacity"],
      image: json["image"],
      date: DateTime.parse(json["date"]),
      cost: json["cost"],
      district: json["district"],
    );
  }

  // Nuevo constructor que toma un String (JSON) y lo convierte a un Event
  factory Event.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Event.fromJson(jsonMap);
  }



}



