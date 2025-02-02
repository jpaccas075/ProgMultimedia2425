import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/note.dart';

// Pantalla de edición de notas.
class EditNoteScreen extends StatefulWidget {
  // Recibe una nota existente y su índice como parámetros.
  final Note note;
  final int index;

  const EditNoteScreen({super.key, required this.note, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  // Controladores para los campos de texto.
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  // Caja de Hive para acceder a las notas.
  late Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores de texto con los valores de la nota existente.
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
    // Obtiene la instancia de la caja de Hive donde se almacenan las notas.
    noteBox = Hive.box<Note>('notes');
  }

  // Guarda los cambios realizados en la nota.
  void _saveChanges() {
    // Actualiza la nota con los valores introducidos por el usuario.
    // Si el usuario deja el título o contenido vacío, se asignan valores por defecto.
    final updatedNote = widget.note
      ..title =
          _titleController.text.isEmpty ? 'Untitled' : _titleController.text
      ..content = _contentController.text.isEmpty
          ? 'No content'
          : _contentController.text;

    // Actualiza la nota en la base de datos en la posición indicada.
    noteBox.putAt(widget.index, updatedNote);
    // Regresa a la pantalla anterior.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual de la aplicación.
    final theme = Theme.of(context);
    // Obtiene el color de texto dinámico basado en el tema.
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_rounded),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            // Campo de texto para editar el título.
            TextField(
              controller: _titleController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                    color: textColor, backgroundColor: Colors.transparent),
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de texto para editar el contenido.
            TextField(
              controller: _contentController,
              style: TextStyle(color: textColor), // Dynamic text style
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(
                    color: textColor, backgroundColor: Colors.transparent),
                filled: true, // Filled background
                fillColor: theme.colorScheme.surface, // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
