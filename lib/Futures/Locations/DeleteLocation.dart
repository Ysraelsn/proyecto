import 'package:http/http.dart' as http;
import 'dart:async';

Future<void> deleteLocation(int id) async {
  final url = Uri.parse('http://127.0.0.1:8000/api/locations/$id');

  try {
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Dato eliminado con éxito
      print('Dato eliminado');
    } else {
      // Hubo un error al eliminar el dato
      print('Error al eliminar el dato: ${response.statusCode}');
    }
  } catch (e) {
    // Hubo un error de conexión o al procesar la solicitud
    print('Error: $e');
  }
}
