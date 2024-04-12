import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Events/EventList.dart';
import 'package:proyecto/models/Event.dart'; // Importar el archivo donde se encuentra la clase Customer

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  Future<List<Event>>? _futureEventList;

  @override
  void initState() {
    super.initState();
    _futureEventList = EventList.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Eventos'),
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: _futureEventList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/screens/EventScreen',
                          arguments: event.id);
                    },
                    child: ListTile(
                      title: Text('Tipo: ${event.eventType}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cliente: ${event.customerName}'),
                          Text('Fecha: ${event.date}'),
                        ],
                      ),
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
