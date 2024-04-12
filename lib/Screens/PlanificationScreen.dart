import 'package:flutter/material.dart';

import 'package:proyecto/Futures/Planifications/PlanificationItem.dart';
import 'package:proyecto/models/Planification.dart';

class PlanificationScreen extends StatefulWidget {
  final int id;

  PlanificationScreen({required this.id});

  @override
  _PlanificationScreenState createState() => _PlanificationScreenState();
}

class _PlanificationScreenState extends State<PlanificationScreen> {
  Future<Planification>? _futurePlanification;

  @override
  void initState() {
    super.initState();
    _futurePlanification = PlanificationItem.fetchPlanification(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Detalles de la Planificación'),
      ),
      body: Container(
        color: Colors.teal[200],
        child: Center(
          child: FutureBuilder<Planification>(
            future: _futurePlanification,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final planification = snapshot.data!;
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
                        offset: const Offset(0.0, 14.0),
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
                              '${planification.eventType}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              '# Asistentes: ${planification.attendance}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              'Presupuesto: \$ ${planification.budget}',
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
                            ),
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
