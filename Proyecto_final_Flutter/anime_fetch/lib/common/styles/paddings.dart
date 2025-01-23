import 'package:flutter/material.dart';

// Clase utilitaria que define diferentes valores de padding utilizados en la aplicación.
class Paddings {
  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 36.0,
  );

  static const noBottomPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: 36.0,
  );

  // Constructor privado para evitar la instanciación de la clase.
  Paddings._();
}
