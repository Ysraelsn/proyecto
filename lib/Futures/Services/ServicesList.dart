import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Service.dart'; // Importar el archivo donde se encuentra la clase Customer

class ServiceList {
  static Future<List<Service>> fetchServices() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/services'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Service> serviceList = [];
      for (var item in data) {
        serviceList.add(Service.fromJson(item));
      }
      return serviceList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
