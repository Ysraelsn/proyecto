import 'package:flutter/material.dart';

class PagosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos'),
        backgroundColor: Color.fromARGB(255, 232, 85, 210),
      ),
      body: Center(
        child: Text(
          'Pagos',
          style: TextStyle(
            fontSize:
                24, // Puedes ajustar el tamaño de la fuente según tus necesidades
            fontWeight: FontWeight
                .bold, // Puedes ajustar el peso de la fuente según tus necesidades
          ),
        ),
      ),
    );
  }
}
