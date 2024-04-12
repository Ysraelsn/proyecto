import 'package:flutter/material.dart';
import 'package:proyecto/models/Planification.dart';
import 'package:proyecto/Futures/Planifications/PlanificationList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanificacionesHome extends StatefulWidget {
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('name');
    return userName;
  }

  @override
  _PlanificacionesHomeState createState() => _PlanificacionesHomeState();
}

class _PlanificacionesHomeState extends State<PlanificacionesHome> {
  Future<List<Planification>>? _futurePlanificationList;

  @override
  void initState() {
    super.initState();
    _futurePlanificationList = PlanificationList.fetchPlanifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String?>(
            future: widget.getUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userName = snapshot.data ?? '';
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: '¡Bienvenido de vuelta: '),
                        TextSpan(
                          text: '$userName',
                          style: const TextStyle(color: Colors.teal),
                        ),
                        const TextSpan(text: '!'),
                      ],
                    ),
                  ),
                );
              }
            },
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Lista de Planificaciones',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                      Expanded(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 500,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        'https://cdn.pixabay.com/photo/2015/05/31/14/23/organizer-791939_1280.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                ? DateFormat('yyyy-MM-dd')
                                                    .format(planification
                                                        .completionDate!)
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
                        ),
                      ),
                    ],
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
