import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {

  Future<bool> createUser(String userName, String name, String email) async {

    //https://the-big-fun-402823.rj.r.appspot.com/api/v1/attendees
    final url = Uri.parse('https://the-big-fun-402823.rj.r.appspot.com/api/v1/attendees');

    final Map<String, dynamic> userData = {
      'userName': userName,
      'name': name,
      'email': email,
      //'password': password,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User created successfully');
      return true;
    } else {
      print('Error creating the user. Status code: ${response.statusCode}');
      return false;
    }
  }
}


