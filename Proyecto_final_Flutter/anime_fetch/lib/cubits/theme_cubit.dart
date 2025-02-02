import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/database_helper/database_helper.dart';

// Clase para gestionar el estado del tema (oscuro o claro) en la aplicación.
class ThemeCubit extends Cubit<ThemeMode> {
  // Constructor que inicializa el estado del tema (utiliza el tema del sistema por defecto).
  ThemeCubit() : super(ThemeMode.system) {
    _getCurrentTheme();
  }

  // Propiedad que devuelve un valor booleano indicando si el modo oscuro está activo.
  bool get isDarkMode => state == ThemeMode.dark;

  // Método privado que obtiene el tema actual almacenado en la base de datos y emite el nuevo estado.
  Future<void> _getCurrentTheme() async {
    // Llama a la base de datos para obtener si el modo oscuro está activado o no.
    final isDarkMode = await DatabaseHelper.instance.isDarkMode;
    // Emite el nuevo estado (modo oscuro o claro) basado en el valor almacenado en la base de datos.
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  // Método que permite cambiar el tema (oscuro o claro) y lo guarda en la base de datos.
  Future<void> changeTheme({required bool isDarkMode}) async {
    // Guarda la preferencia de tema en la base de datos.
    await DatabaseHelper.instance.setDarkMode(isDarkMode);
    // Emite el nuevo estado (modo oscuro o claro) basado en el valor recibido como parámetro.
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
