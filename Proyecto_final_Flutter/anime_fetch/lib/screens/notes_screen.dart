import 'package:anime_fetch/models/note.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'edit_note_screen.dart';

// Pantalla que muestra una lista de notas almacenadas usando Hive.
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Caja de Hive para almacenar notas.
  late final Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    // Inicializa la caja para acceder a los datos almacenados.
    noteBox = Hive.box<Note>('notes');
  }

  void _addNote() {
    // Crea una nueva nota con valores por defecto.
    final newNote = Note()
      ..title = 'New Note'
      ..content = 'Note content';

    // Agrega la nueva nota a la caja.
    noteBox.add(newNote);
    setState(
        () {}); // Actualiza el estado para reflejar los cambios en la interfaz.
  }

  void _deleteNoteAt(int index) {
    // Elimina la nota en el índice especificado.
    noteBox.deleteAt(index);
    setState(() {}); // Actualiza el estado tras la eliminación.
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual de la aplicación para estilos dinámicos.
    final theme = Theme.of(context);
    final textColor =
        theme.textTheme.bodyLarge?.color; // Color de texto según el tema.
    final cardColor =
        theme.cardColor; // Color de fondo de las tarjetas según el tema.

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyNotes'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        // Escucha cambios en la caja de Hive para actualizar la interfaz automáticamente.
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box, _) {
          // Verifica si la caja está vacía.
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No notes available'),
            );
          }

          // Construye una lista de las notas almacenadas.
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: box.values.length, // Número de elementos en la lista.
            itemBuilder: (context, index) {
              final note =
                  box.getAt(index); // Obtiene la nota en el índice actual.

              return Card(
                color: cardColor, // Usa el color del tema para la tarjeta.
                elevation: 4,
                child: ListTile(
                  title: Text(
                    note?.title ??
                        'Untitled', // Muestra el título o "Untitled" si está vacío.
                    style: TextStyle(color: textColor),
                  ),
                  subtitle: Text(
                    note?.content ??
                        'No content', // Muestra el contenido o "No content" si está vacío.
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      // Navega a la pantalla de edición cuando se pulsa una nota.
                      builder: (_) => EditNoteScreen(note: note!, index: index),
                    ),
                  ),
                  trailing: IconButton(
                    // Botón para eliminar la nota.
                    icon: Icon(Icons.delete, color: textColor),
                    onPressed: () => _deleteNoteAt(
                        index), // Llama a la función para eliminar la nota.
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Botón flotante para agregar nuevas notas.
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
