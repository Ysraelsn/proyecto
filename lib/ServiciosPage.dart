import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Services/ServicesList.dart';
import 'package:proyecto/models/Service.dart'; // Importar el archivo donde se encuentra la clase Customer

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  Future<List<Service>>? _futureServiceList;

  @override
  void initState() {
    super.initState();
    _futureServiceList = ServiceList.fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compañías'),
      ),
      body: Center(
        child: FutureBuilder<List<Service>>(
          future: _futureServiceList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final service = snapshot.data![index];
                  return ListTile(
                    title: Text('Nombre: ${service.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Precio: ${service.price}'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
