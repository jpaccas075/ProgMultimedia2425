import 'package:flutter/foundation.dart';

// Representa la información de una imagen asociada a un objeto.
@immutable
class Picture {
  final String medium; // URL de una versión de tamaño mediano de la imagen.
  final String large; // URL de una versión de tamaño grande de la imagen.

  const Picture({
    required this.medium,
    required this.large,
  });

  // Método para crear una instancia de 'Picture' a partir de un JSON.
  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      medium: json['medium'],
      large: json['large'],
    );
  }
}
