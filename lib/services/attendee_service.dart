import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendeeService {
  final String baseUrl = "https://the-big-fun-402823.rj.r.appspot.com/api/v1/attendees";

  Future<Map<String, dynamic>> getAttendeeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar el Attendee');
    }
  }
}