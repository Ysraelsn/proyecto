import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthResponse {
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, dynamic>? userData;
  final String? accessToken;

  AuthResponse({
    required this.isSuccess,
    this.errorMessage,
    this.userData,
    this.accessToken,
  });
}

Future<AuthResponse> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Inicio de sesión exitoso
    final data = jsonDecode(response.body);
    final userData = data['profile'];
    final accessToken = data['accessToken'];
    return AuthResponse(
        isSuccess: true, userData: userData, accessToken: accessToken);
  } else {
    // Error de inicio de sesión
    final errorMessage = 'Error de inicio de sesión: ${response.statusCode}';
    return AuthResponse(isSuccess: false, errorMessage: errorMessage);
  }
}

Future<AuthResponse> register(
    String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Registro exitoso
    final data = jsonDecode(response.body);
    final userData = data['profile'];
    final accessToken = data['access_token'];
    return AuthResponse(
        isSuccess: true, userData: userData, accessToken: accessToken);
  } else {
    // Error de registro
    final errorMessage = 'Error de registro: ${response.statusCode}';
    return AuthResponse(isSuccess: false, errorMessage: errorMessage);
  }
}
