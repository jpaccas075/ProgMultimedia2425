import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/home_screen.dart';

// Pantalla tipo Splash que se muestra al inicio de la aplicación.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Se agrega un retraso de 6 segundos antes de navegar a la pantalla Home.
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            // Animación de transición: en este caso, una transición de fundido (fade).
            return FadeTransition(opacity: animation, child: child);
          },
          // Duración de la transición en milisegundos (500 ms).
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // Imagen de fondo de la pantalla.
            image: AssetImage('assets/bg_original.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen del logo en el centro.
              Image.asset('assets/icono.png', width: 150),
              const SizedBox(height: 30),
              // Contenedor con un fondo semitransparente y bordes redondeados.
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      // Sombra del contenedor.
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                      blurRadius: 60, // Desenfoque de la sombra.
                      spreadRadius: 20, // Extensión de la sombra.
                    ),
                  ],
                ),
                child: Text(
                  // Texto que se muestra en el contenedor.
                  'ANIMEFETCH\n\n'
                  'ALL ANIME,\n'
                  'ONE PLACE',
                  textAlign: TextAlign.center,
                  // Fuente de Google Fonts.
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
