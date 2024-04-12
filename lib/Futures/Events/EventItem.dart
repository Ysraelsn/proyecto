import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Event.dart'; // Importar el archivo donde se encuentra la clase Customer

class EventItem {
  static Future<Event> fetchEvent(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/events/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Event.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
