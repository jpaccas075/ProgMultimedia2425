import 'package:flutter/material.dart';

import '/models/anime_category.dart';
import '/views/anime_grid_view.dart';

// Pantalla que muestra diferentes categorías de animes organizadas en pestañas.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Genera una lista de pestañas basadas en las categorías de anime.
  // Cada pestaña muestra el título de la categoría.
  final _animeTabs = animeCategories
      .map((animeCategory) => Tab(
            text: animeCategory.title,
          ))
      .toList();

  // Genera una lista de vistas correspondientes a las categorías.
  // Cada vista muestra los animes en un formato de cuadrícula usando 'AnimeGridView'.
  final _screens = animeCategories
      .map((animeCategory) => AnimeGridView(
            category: animeCategory,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9, // Número de pestañas. En este caso, hay 9 categorías.
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anime Categories'),
          bottom: TabBar(
            // Lista de pestañas generadas dinámicamente a partir de '_animeTabs'.
            tabs: _animeTabs,
            isScrollable:
                true, // Permite desplazarse horizontalmente si hay muchas pestañas.
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorColor: Colors.red,
            labelColor: Colors.red,
          ),
        ),
        body: TabBarView(
          // Contenido correspondiente a cada pestaña, generado desde '_screens'.
          children: _screens,
        ),
      ),
    );
  }
}
