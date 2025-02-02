import 'package:shared_preferences/shared_preferences.dart';

import '/constants/constants.dart';

class DatabaseHelper {
  // Constructor privado para implementar el patrón singleton.
  DatabaseHelper._privateConstructor();
  // Instancia única de la clase.
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Instancia de SharedPreferences (base de datos local).
  static SharedPreferences? _database;

  // Obtener la base de datos.
  Future<SharedPreferences> get database async {
    // Si la base de datos ya está inicializada, la devuelve directamente.
    if (_database != null) return _database!;

    // Si no está inicializada, la inicializa y la devuelve.
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa la base de datos.
  Future<SharedPreferences> _initDatabase() async {
    // Obtiene una instancia de SharedPreferences.
    _database = await SharedPreferences.getInstance();
    return _database!;
  }

  // Getters y setters para el modo del tema (oscuro o claro).
  // Obtiene el estado actual del modo oscuro (true si está activado, false si está desactivado).
  Future<bool> get isDarkMode async {
    final db = await instance.database;
    return db.getBool(Constants.isDarkMode) ?? false; // Si no se encuentra el valor, devuelve false por defecto.
  }

  // Establece el modo oscuro (true para activarlo, false para desactivarlo).
  Future<bool> setDarkMode(bool isDark) async {
    final db = await instance.database;
    return await db.setBool(Constants.isDarkMode, isDark); // Establece el valor del modo oscuro.
  }

  // Getters y setters para el idioma del título del anime (inglés o no).
  // Obtiene el estado actual del idioma del título (true si está en inglés, false si no).
  Future<bool> get isEnglish async {
    final db = await instance.database;
    return db.getBool(Constants.isEnglish) ?? false; // Si no se encuentra el valor, devuelve false por defecto.
  }

  // Establece el idioma del título del anime (true para inglés, false para japones).
  Future<bool> setIsEnglish(bool isEnglish) async {
    final db = await instance.database;
    return await db.setBool(Constants.isEnglish, isEnglish); // Establece el valor del idioma.
  }
}
