import 'package:flutter/material.dart';

// Widget personalizado que representa un botón de retroceso al estilo iOS.
class IosBackButton extends StatelessWidget {
  const IosBackButton({
    super.key,
    required this.onPressed,
    this.borderWidth = 2.0,
  });

  // Función que se ejecuta cuando el usuario presiona el botón.
  final VoidCallback onPressed;

  // Grosor del borde del botón.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context)
              .shadowColor, // Color de fondo basado en el tema actual.
        ),
        width: 35,
        height: 35,
        alignment: Alignment.center, // Centra el icono dentro del contenedor.
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Theme.of(context)
              .primaryColor, // Color del icono basado en el tema.
        ),
      ),
    );
  }
}
