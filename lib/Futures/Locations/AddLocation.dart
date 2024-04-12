import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> storeLocation(String data) async {
  String url = 'http://127.0.0.1:8000/api/locations';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': data,
      }),
    );

    if (response.statusCode == 200) {
      print('La ubicación fue almacenada con éxito.');
      return true;
    } else {
      print(
          'Error al almacenar la ubicación. Código de estado: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
