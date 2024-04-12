import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Planification.dart'; // Importar el archivo donde se encuentra la clase Customer

class PlanificationList {
  static Future<List<Planification>> fetchPlanifications() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/planifications'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Planification> planificationList = [];
      for (var item in data) {
        planificationList.add(Planification.fromJson(item));
      }
      return planificationList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
