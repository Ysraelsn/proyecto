import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Company.dart'; // Importar el archivo donde se encuentra la clase Customer

class CompanyItem {
  static Future<Company> fetchCompany(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/companies/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Company.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
