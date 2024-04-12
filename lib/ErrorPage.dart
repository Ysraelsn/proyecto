import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
        backgroundColor: Color(0xFFA5D6A7),
      ),
      body: Center(
        child: Text(
          'Error en la Ruta',
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
