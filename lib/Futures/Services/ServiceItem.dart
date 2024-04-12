import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Service.dart'; // Importar el archivo donde se encuentra la clase Customer

class ServiceItem {
  static Future<Service> fetchService(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/services/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Service.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
