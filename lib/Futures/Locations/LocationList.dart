import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Location.dart'; // Importar el archivo donde se encuentra la clase Customer

class LocationList {
  static Future<List<Location>> fetchLocations() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/locations')); 
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Location> locationList = [];
      for (var item in data) {
        locationList.add(Location.fromJson(item));
      }
      return locationList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
