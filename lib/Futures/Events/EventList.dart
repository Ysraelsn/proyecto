import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Event.dart'; // Importar el archivo donde se encuentra la clase Customer

class EventList {
  static Future<List<Event>> fetchEvents() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/events'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Event> eventList = [];
      for (var item in data) {
        eventList.add(Event.fromJson(item));
      }
      return eventList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
