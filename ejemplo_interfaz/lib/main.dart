import 'package:flutter/material.dart';
import 'secciones/superior.dart';
import 'secciones/media.dart';
import 'secciones/inferior.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: obtieneAppBar(), // Función que devuelve el AppBar
      body: const Column(
        children: [
          SeccionSuperior(), // Parte superior
          SeccionMedia(), // Parte media
          SeccionInferior(), // Parte inferior
        ],
      ),
    );
  }
}
