import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Services/ServiceItem.dart';
import 'package:proyecto/models/Service.dart';

class ServiceScreen extends StatefulWidget {
  final int id;

  ServiceScreen({required this.id});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Future<Service>? _futureService;

  @override
  void initState() {
    super.initState();
    _futureService = ServiceItem.fetchService(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Detalles del Servicio'),
      ),
      body: Center(
        child: FutureBuilder<Service>(
          future: _futureService,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final service = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${service.name}',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text('Descripción: ${service.description}'),
                  Text('Precio: ${service.price}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
