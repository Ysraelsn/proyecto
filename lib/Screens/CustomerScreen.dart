import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Customers/ClientesItem.dart';
import 'package:proyecto/models/Customer.dart';

class CustomerScreen extends StatefulWidget {
  final int id;

  CustomerScreen({required this.id});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  Future<Customer>? _futureCustomer;

  @override
  void initState() {
    super.initState();
    _futureCustomer = CustomerItem.fetchCustomer(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Detalles del Cliente'),
      ),
      body: Center(
        child: FutureBuilder<Customer>(
          future: _futureCustomer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final customer = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${customer.first_name} ${customer.second_name} ${customer.surname} ${customer.second_surname}',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text('Email: ${customer.email}'),
                  Text('Teléfono: ${customer.phone_number}'),
                  Text('Edad: ${customer.age}'),
                  Text('Presupuesto: ${customer.budget}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
