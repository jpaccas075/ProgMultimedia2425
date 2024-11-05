import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';

class ColumnPhotosScreen extends StatelessWidget {
  const ColumnPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotos en Columna'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        // Centra el contenido en el cuerpo de la pantalla
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los widgets hijos verticalmente
          children: <Widget>[
            Image.asset(
                'assets/images/foto.png',
                width: 200,
                height: 200),
            Image.asset(
                'assets/images/foto2.jpg',
                width: 200,
                height: 200),
            Image.asset(
                'assets/images/foto3.jpg',
                width: 200,
                height: 200),
          ],
        ),
      ),
    );
  }
}
