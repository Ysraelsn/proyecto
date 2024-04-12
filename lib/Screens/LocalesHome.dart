import 'package:proyecto/Futures/Locations/LocationList.dart';
import 'package:proyecto/models/Location.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LocalesHome extends StatefulWidget {
  @override
  _LocalesHomeState createState() => _LocalesHomeState();
}

class _LocalesHomeState extends State<LocalesHome> {
  Future<List<Location>>? _futureLocationList;

  @override
  void initState() {
    super.initState();
    _futureLocationList = LocationList.fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: _futureLocationList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 400, // Ajusta la altura según tus necesidades
                  enableInfiniteScroll: true, // Permite desplazamiento infinito
                  autoPlay: true, // Reproducción automática
                  autoPlayInterval: Duration(
                      seconds: 3), // Intervalo de reproducción automática
                  autoPlayAnimationDuration: Duration(
                      milliseconds:
                          800), // Duración de la animación de reproducción automática
                  autoPlayCurve: Curves
                      .fastOutSlowIn, // Curva de la animación de reproducción automática
                  pauseAutoPlayOnTouch:
                      true, // Pausa la reproducción automática al tocar
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, realIndex) {
                  final location = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/screens/LocationScreen',
                          arguments: location.id);
                    },
                    child: Card(
                      color: Colors.teal.shade50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              location.imageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${location.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              return CarouselSlider.builder(
                options: CarouselOptions(
                  height: 600, // Ajusta la altura según tus necesidades
                  enableInfiniteScroll: true, // Permite desplazamiento infinito
                  autoPlay: false, // Reproducción automática
                  autoPlayInterval: const Duration(
                      seconds: 3), // Intervalo de reproducción automática
                  autoPlayAnimationDuration: const Duration(
                      milliseconds:
                          800), // Duración de la animación de reproducción automática
                  autoPlayCurve: Curves
                      .fastOutSlowIn, // Curva de la animación de reproducción automática
                  pauseAutoPlayOnTouch:
                      true, // Pausa la reproducción automática al tocar
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, realIndex) {
                  final location = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/screens/LocationScreen',
                          arguments: location.id);
                    },
                    child: Card(
                      color: Colors.teal.shade50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              location.imageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${location.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
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
    );
  }
}
