import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Customers/ClientesList.dart';
import 'package:proyecto/models/Customer.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  Future<List<Customer>>? _futureCustomerList;

  @override
  void initState() {
    super.initState();
    _futureCustomerList = CustomerList.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: Center(
        child: FutureBuilder<List<Customer>>(
          future: _futureCustomerList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final customer = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/screens/CustomerScreen',
                          arguments: customer.id);
                    },
                    child: ListTile(
                      title: Text(
                        '${customer.first_name} ${customer.second_name} '
                        '${customer.surname} ${customer.second_surname}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        /*children: [
                          Text('Email: ${customer.email}'),
                          Text('Phone Number: ${customer.phone_number}'),
                          Text('Age: ${customer.age}'),
                          Text('Budget: ${customer.budget}'),
                        ],*/
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
