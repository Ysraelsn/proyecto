import 'package:flutter/material.dart';

class FechasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fechas'),
        backgroundColor: Color.fromARGB(255, 88, 119, 222),
      ),
      body: Center(
        child: Text(
          'Fechas',
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
