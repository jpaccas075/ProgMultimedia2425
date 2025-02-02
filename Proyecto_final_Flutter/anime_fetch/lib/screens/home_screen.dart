import 'package:flutter/material.dart';

import '/screens/animes_screen.dart';
import '/screens/categories_screen.dart';
import '/screens/notes_screen.dart';
import '/screens/search_screen.dart';
import '/screens/settings_screen.dart';

/// Pantalla que gestiona la navegación entre diferentes pantallas.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.index});

  final int?
      index; // Índice opcional que define la pantalla inicial seleccionada.

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice seleccionado actualmente en el 'BottomNavigationBar'.
  int _selectedIndex = 0;

  @override
  void initState() {
    // Si se pasa un índice desde el constructor, se utiliza como índice inicial.
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    super.initState();
  }

  // Lista de destinos del 'BottomNavigationBar'.
  final _destinations = [
    const NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
    const NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Search'),
    const NavigationDestination(
        icon: Icon(Icons.category), label: 'Categories'),
    const NavigationDestination(icon: Icon(Icons.note_add_rounded), label: 'MyNotes'),
    const NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  // Lista de pantallas asociadas a los destinos.
  final _screens = [
    AnimesScreen(),
    SearchScreen(),
    CategoriesScreen(),
    NotesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Muestra la pantalla correspondiente al índice seleccionado.
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 12,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        selectedIndex: _selectedIndex,
        destinations: _destinations,
        onDestinationSelected: (value) {
          // Actualiza el índice seleccionado cuando el usuario selecciona un destino.
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
