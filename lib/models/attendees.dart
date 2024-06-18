import 'package:big_fun_app/models/ioTDevice.dart';

class Attendees{
  int id;
  String userName;
  String name;
  String email;


  Attendees({
    required this.id,
    required this.userName,
    required this.name,
    required this.email,
  });

  static Attendees fromJson(Map<String, dynamic> json){
    return Attendees(
      id: json["id"] as int,
      userName: json["userName"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
    );
  }
  
}