
import 'dart:convert';

class Event{

  int id;
  String name;
  String address;
  int capacity;
  String imageUrl;
  DateTime date;
  int cost;
  String district;

  Event(
      { required this.id,
        required this.name,
        required this.address,
        required this.capacity,
        required this.imageUrl,
        required this.date,
        required this.cost,
        required this.district
      }
      );

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"] as int,
      name: json["name"] as String,
      address: json["address"] as String,
      capacity: json["capacity"] as int,
      imageUrl: json["imageUrl"] as String,
      date: DateTime.parse(json["date"]),
      cost: json["cost"] as int,
      district: json["district"] as String,
    );
  }

  factory Event.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Event.fromJson(jsonMap);
  }
}



