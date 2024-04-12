import 'package:flutter/material.dart';
import 'package:proyecto/models/Planification.dart';
import 'package:proyecto/Futures/Planifications/PlanificationList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart'; // Importar el paquete intl

class PlanificacionesPage extends StatefulWidget {
  @override
  _PlanificacionesPageState createState() => _PlanificacionesPageState();
}

class _PlanificacionesPageState extends State<PlanificacionesPage> {
  Future<List<Planification>>? _futurePlanificationList;

  @override
  void initState() {
    super.initState();
    _futurePlanificationList = PlanificationList.fetchPlanifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planificaciones'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lista de Planificaciones',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Planification>>(
              future: _futurePlanificationList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 600,
                      enableInfiniteScroll: true,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index, realIndex) {
                      final planification = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/screens/PlanificationScreen',
                              arguments: planification.id);
                        },
                        child: Card(
                          color: Colors.teal.shade50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2016/07/02/12/21/eclipse-1492818_1280.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${planification.eventType}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      planification.completionDate != null
                                          ? DateFormat('yyyy-MM-dd').format(
                                              planification.completionDate!)
                                          : 'Fecha no disponible',
                                    ),
                                  ],
                                ),
                              ),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        splashColor: Colors.teal.shade400,
        tooltip: 'Agregar Planificación',
        onPressed: () {
          Navigator.pushNamed(
              context, '/screens/Planifications/AddPlanification');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
