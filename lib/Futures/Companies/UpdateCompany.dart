import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<void> updateCompany(int id, Map<String, dynamic> data) async {
  final url = Uri.parse('http://127.0.0.1:8000/api/companies/$id');

  try {
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
    } else {
      // Hubo un error al actualizar el dato
      print('Error al actualizar el dato: ${response.statusCode}');
    }
  } catch (e) {
    // Hubo un error de conexión o al procesar la solicitud
    print('Error: $e');
  }
}
