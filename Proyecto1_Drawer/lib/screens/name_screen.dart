import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre y Apellidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Jorge Pacheco Castro',
              style:
                  GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '2ºDAM',
              style:
                  GoogleFonts.fredoka(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              'https://github.com/jpaccas075/ProgMultimedia2425',
              style: GoogleFonts.fredoka(fontSize: 14,  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
