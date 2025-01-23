import 'package:flutter/material.dart';

// Clase que define los temas de la aplicación (oscuro y claro).
class AppTheme {
  /* Tema oscuro de la aplicación.
  Define los colores y estilos para un tema de apariencia oscura. */
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey.shade900,
    primaryColor: Colors.white,
    shadowColor: Colors.black54,
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(  
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        backgroundColor: Colors.black,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(secondary: Colors.grey.shade900)
        .copyWith(surface: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.white70,
      ),
    ),
  );

  /* Tema claro de la aplicación.
  Define los colores y estilos para un tema de apariencia clara. */
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    shadowColor: Colors.white54,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        backgroundColor: Colors.white,
        color: Colors.black,
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(surface: Colors.white),
  );
}
