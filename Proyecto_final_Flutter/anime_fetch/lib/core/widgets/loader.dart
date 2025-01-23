import 'package:flutter/material.dart';

// Widget que muestra un indicador de carga circular.
// Se utiliza para mostrar al usuario que la aplicación
// está realizando alguna operación en segundo plano.
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
