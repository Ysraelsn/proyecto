import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Locations/LocationItem.dart';
import 'package:proyecto/models/Location.dart';

import 'package:proyecto/Futures/Locations/DeleteLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  final int id;

  LocationScreen({required this.id});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Location>? _futureLocation;
  bool _isUserLoggedIn = false;

  void _navigateToHome(int id) {
    Navigator.pushReplacementNamed(
      context,
      '/',
    );
  }

  @override
  void initState() {
    super.initState();
    _futureLocation = LocationItem.fetchLocation(widget.id);
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
        title: const Text('Detalles del Local'),
      ),
      body: Center(
        child: FutureBuilder<Location>(
          future: _futureLocation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final location = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    location.imageURL,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    '${location.name}',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text('Dirección: ${location.address}'),
                  Text('Capacidad: ${location.capacity}'),
                  Text('Precio: ${location.price}'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (_isUserLoggedIn)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/screens/Locations/UpdateLocation',
                                arguments: location);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white),
                          child: const Text('Actualizar'),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            deleteLocation(widget.id).then((_) {
                              _navigateToHome(widget.id);
                            }).catchError((error) {
                              print('Error: $error');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
