import 'package:flutter/material.dart';

// Widget que muestra una imagen desde una URL utilizando 'Image.network()'.
class NetworkImageView extends StatelessWidget {
  const NetworkImageView({super.key, required this.imageUrl});

  // URL de la imagen a cargar desde la red.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          imageUrl, // Carga la imagen desde la URL proporcionada.
          fit: BoxFit.cover, // Ajusta la imagen para que cubra el espacio disponible.
        ),
      ),
    );
  }
}
