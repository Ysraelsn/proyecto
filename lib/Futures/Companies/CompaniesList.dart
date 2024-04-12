import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/models/Company.dart';
import 'dart:developer' as developer;

class CompanyList {
  static Future<List<Company>> fetchCompanies() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/companies'));
    if (response.statusCode == 200) {
      developer.log(response.body);

      final List<dynamic> data = jsonDecode(response.body);
      List<Company> companyList = [];
      for (var item in data) {
        companyList.add(Company.fromJson(item));
      }

      return companyList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
