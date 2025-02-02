import 'package:hive/hive.dart';

// Genera el archivo de código necesario para la serialización y deserialización de los datos de Hive.
// Este archivo se genera automáticamente al ejecutar el comando de build_runner.
part 'note.g.dart';

// Define una clase que será utilizada por Hive como modelo para almacenar datos.
@HiveType(typeId: 0)
class Note {
  // Cada campo dentro de la clase debe ser anotado con @HiveField para que Hive lo reconozca.
  // Los índices de los campos deben ser únicos y constantes para evitar problemas de compatibilidad con versiones futuras.
  @HiveField(0)
  late String title; // Campo para almacenar el título de la nota.

  @HiveField(1)
  late String content; // Campo para almacenar el contenido de la nota.
}
