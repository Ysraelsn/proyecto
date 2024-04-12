import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Customer.dart'; // Importar el archivo donde se encuentra la clase Customer

class CustomerList {
  static Future<List<Customer>> fetchCustomers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/customers'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Customer> customerList = [];
      for (var item in data) {
        customerList.add(Customer.fromJson(item));
      }
      return customerList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
