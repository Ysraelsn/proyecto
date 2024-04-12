import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class SearchService {
  Future<List<dynamic>> searchEvents(String keyword) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/events/search?keyword=$keyword'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> events = jsonDecode(response.body);
      return events;
    } else {
      throw Exception('Error al realizar la búsqueda');
    }
  }
}
