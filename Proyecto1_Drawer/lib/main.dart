import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
// Importación unificada
import 'screens/screens.dart';

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
      // Rutas nombradas
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/name': (context) => const NameScreen(),
        '/rowPhotos': (context) => const RowPhotosScreen(),
        '/columnPhotos': (context) => const ColumnPhotosScreen(),
        '/icons': (context) => const IconsScreen(),
        '/challenge': (context) => const ChallengeScreen(),
        '/disposition': (context) => const DispositionScreen(),
        '/counter': (context) => const CounterScreen(),
        '/instagram': (context) => const MyHomePage(),
        '/game': (context) => const GameScreen(),
      },
    );
  }
}
