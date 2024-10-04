import 'package:drawer/menu_lateral.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario de la aplicación
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejercicio Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define el tema de la aplicación con un color primario azul
      ),
      home: const HomeScreen(), // Widget que se muestra al iniciar la aplicación
    );
  }
}
