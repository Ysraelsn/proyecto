import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Companies/CompaniesItem.dart';
import 'package:proyecto/models/Company.dart';

class CompanyScreen extends StatefulWidget {
  final int id;

  CompanyScreen({required this.id});

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Future<Company>? _futureCompany;

  @override
  void initState() {
    super.initState();
    _futureCompany = CompanyItem.fetchCompany(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Detalles del Cliente'),
      ),
      body: Center(
        child: FutureBuilder<Company>(
          future: _futureCompany,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final company = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${company.name}',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text('Descripción: ${company.description}'),
                  Text('Contacto: ${company.contact}'),
                  Text('Tipo: ${company.type}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
