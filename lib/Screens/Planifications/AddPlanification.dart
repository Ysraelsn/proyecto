import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AddPlanificationScreen extends StatefulWidget {
  @override
  _AddPlanificationScreenState createState() => _AddPlanificationScreenState();
}

class _AddPlanificationScreenState extends State<AddPlanificationScreen> {
  List<int> ageList = List.generate(100, (index) => index + 1);
  List<String> eventTypes = [
    'Despedida de Soltera/o',
    'Reunión Familiar',
    'Boda',
    'Baby Shower',
    'Cumpleaños',
    'Aniversario',
    'Graduación',
    'Evento Corporativo',
    'Otro'
  ];
  final _dateController = TextEditingController();

  final Map<String, dynamic> _formData = {};
  final _formKey = GlobalKey<FormState>();
  int? _selectedAge;
  String? _selectedEventType;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/agregar-datos'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(_formData),
        );

        if (response.statusCode == 200) {
          // Datos agregados correctamente
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Datos agregados correctamente')),
          );
        } else {
          // Error al agregar datos
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al agregar datos')),
          );
        }
      } catch (e) {
        // Error de conexión
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión')),
        );
      }
    }
  }

  _customerHeader(context) {
    return const Column(
      children: [
        Text(
          "Datos del Cliente",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text("Ingresa los datos del Cliente"),
      ],
    );
  }

  _dateHeader(context) {
    return const Column(
      children: [
        Text(
          "Datos de la Fecha",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text("Ingresa los datos de las Fechas"),
      ],
    );
  }

  _paymentHeader(context) {
    return const Column(
      children: [
        Text(
          "Datos de Pago",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text("Ingresa los datos de los pagos."),
      ],
    );
  }

  _eventHeader(context) {
    return const Column(
      children: [
        Text(
          "Datos del Evento",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text("Ingresa los datos del evento."),
      ],
    );
  }

  _customerForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Primer Nombre",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su nombre';
              }
              return null;
            },
            onSaved: (value) {
              _formData['first_name'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Segundo Nombre",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            onSaved: (value) {
              _formData['second_name'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Primer Apellido",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su nombre';
              }
              return null;
            },
            onSaved: (value) {
              _formData['surname'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Segundo Apellido",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            onSaved: (value) {
              _formData['second_surname'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su correo electrónico.';
              }
              return null;
            },
            onSaved: (value) {
              _formData['email'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Teléfono",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su número telefónico';
              }
              return null;
            },
            onSaved: (value) {
              _formData['phone_number'] = value;
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            value: _selectedAge,
            decoration: InputDecoration(
              hintText: "Edad",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            items: ageList.map((age) {
              return DropdownMenuItem<int>(
                value: age,
                child: Text(age.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedAge = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor, seleccione una edad';
              }
              return null;
            },
            onSaved: (value) {
              _formData['age'] = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Ingrese presupuesto",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.teal.withOpacity(0.1),
              filled: true,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese su presupuesto';
              }
              return null;
            },
            onSaved: (value) {
              _formData['budget'] = value;
            },
          ),
        ],
      ),
    );
  }

  _dateForm(context) {
    return const Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Agrega aquí los TextFormField para los campos de la tabla Date
        ],
      ),
    );
  }

  _eventForm(BuildContext context) {
    return const Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Agrega aquí los TextFormField para los campos de la tabla Date
        ],
      ),
    );
  }

  _paymentForm(context) {
    return const Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Agrega aquí los TextFormField para los campos de la tabla Payment
        ],
      ),
    );
  }

  _planificationForm(context) {
    return const Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Agrega aquí los TextFormField para los campos de la tabla Planification
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customerHeader(context),
              const SizedBox(height: 15),
              _customerForm(context),
              const SizedBox(height: 15),
              _eventHeader(context),
              const SizedBox(height: 15),
              _eventForm(context),
              const SizedBox(height: 15),
              _dateHeader(context),
              const SizedBox(height: 15),
              _dateForm(context),
              const SizedBox(height: 15),
              _paymentHeader(
                context,
              ),
              _paymentForm(context),
              _planificationForm(context),
            ],
          ),
        ),
      ),
    );
  }
}
