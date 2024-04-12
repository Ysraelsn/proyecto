import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Locations/UpdateLocation.dart';
import 'package:proyecto/models/Location.dart';

class UpdateLocationScreen extends StatefulWidget {
  final Location location;

  const UpdateLocationScreen({Key? key, required this.location})
      : super(key: key);

  @override
  _UpdateLocationScreenState createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _capacityController;
  late TextEditingController _priceController;
  late TextEditingController _imageURLController;

  void _navigateToLocationScreen(int id) {
    Navigator.pushReplacementNamed(
      context,
      '/screens/LocationScreen',
      arguments: id,
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.location.name);
    _addressController = TextEditingController(text: widget.location.address);
    _capacityController =
        TextEditingController(text: widget.location.capacity.toString());
    _priceController =
        TextEditingController(text: widget.location.price.toString());
    _imageURLController = TextEditingController(text: widget.location.imageURL);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _capacityController.dispose();
    _priceController.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Local'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una dirección';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una capacidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageURLController,
                decoration: const InputDecoration(labelText: 'URL de imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una URL de imagen';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Obtener los nuevos datos ingresados por el usuario
            final newData = {
              'name': _nameController.text,
              'address': _addressController.text,
              'capacity': int.parse(_capacityController.text),
              'price': double.parse(_priceController.text),
              'imageURL': _imageURLController.text,
            };

            // Llamar a la función updateLocation con el id y los nuevos datos
            updateLocation(widget.location.id, newData).then((_) {
              // Si se completó correctamente, navegar a LocationScreen
              _navigateToLocationScreen(widget.location.id);
            }).catchError((error) {
              // Manejar cualquier error aquí
              print('Error: $error');
            });
          }
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
