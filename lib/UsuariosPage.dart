import 'package:flutter/material.dart';

class UsuariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
        backgroundColor: Color.fromARGB(255, 250, 254, 2),
      ),
      body: Center(
        child: Text(
          'Usuarios',
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
