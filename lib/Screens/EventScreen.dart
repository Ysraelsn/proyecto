import 'package:flutter/material.dart';

import 'package:proyecto/Futures/Events/EventItem.dart';
import 'package:proyecto/models/Event.dart';

class EventScreen extends StatefulWidget {
  final int id;

  EventScreen({required this.id});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Future<Event>? _futureEvent;

  @override
  void initState() {
    super.initState();
    _futureEvent = EventItem.fetchEvent(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Detalles del Evento'),
      ),
      body: Container(
        color: Colors.teal[200],
        child: Center(
          child: FutureBuilder<Event>(
            future: _futureEvent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final event = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 14.0,
                        offset: Offset(0.0, 14.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/09/23/10/38/teal-953401_1280.jpg', // Reemplaza con la URL de la imagen real
                                width: 300.0,
                                height: 300.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            Text(
                              event.eventType,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Nombre del Cliente: ${event.customerName}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              'Local: ${event.locationName}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.teal[700],
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 25.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                      width:
                                          16.0), // Espacio entre el icono y el texto
                                  Text(
                                    event.date,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
