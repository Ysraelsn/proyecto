import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/User.dart'; // Importar el archivo donde se encuentra la clase Customer

class UserItem {
  static Future<User> fetchUser(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/users/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
