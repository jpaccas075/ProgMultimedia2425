import 'package:flutter/material.dart';

@immutable
class Constants {
  // Constante que indica si el modo oscuro está activado.
  // Se utiliza para almacenar esta preferencia en almacenamiento persistente.
  static const String isDarkMode = 'is_dark_mode';

  // Constante que indica si el idioma actual es inglés.
  // Sirve como clave para almacenar esta preferencia.
  static const String isEnglish = 'is_english';

  // Constructor privado para prevenir la creación de instancias de esta clase.
  const Constants._();
}
