import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'package:drawer/screens/screens.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: obtieneAppBar(), // Función que devuelve el AppBar
      drawer: const AppDrawer(),
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
