import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Locations/LocationList.dart';
import 'package:proyecto/models/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:proyecto/Screens/LocationScreen.dart';

class Locales extends StatefulWidget {
  @override
  _LocalesState createState() => _LocalesState();
}

class _LocalesState extends State<Locales> {
  Future<List<Location>>? _futureLocationList;
  final PageController _pageController = PageController();
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _futureLocationList = LocationList.fetchLocations();
    _checkLoggedInUser();
  }

  Future<void> _checkLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isUserLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Lista de Locales'),
      ),
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: _futureLocationList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return PageView.builder(
                controller: _pageController,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
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
                                /*Text('Dirección: ${location.address}'),
                                Text('Capacidad: ${location.capacity}'),
                                Text('Precio: ${location.price}'),*/
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
      floatingActionButton: _isUserLoggedIn
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              splashColor: Colors.teal.shade400,
              tooltip: 'Agregar Local',
              onPressed: () {
                Navigator.pushNamed(context, '/screens/Locations/AddLocation');
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
