import 'dart:async';

import 'package:flutter/material.dart';

import '/api/get_anime_by_search.dart';
import '/common/styles/paddings.dart';
import '/models/anime.dart';
import '/models/anime_node.dart';
import '/widgets/anime_list_tile.dart';

// Pantalla de búsqueda de animes.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50), // Espaciado superior.
            const Text(
              'Search for animes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Espaciado entre el título y el botón.
            // Botón que activa el cuadro de búsqueda.
            InkWell(
              onTap: () {
                // Abre el cuadro de búsqueda personalizado al hacer clic.
                showSearch(context: context, delegate: AnimeSearchDelegate());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 70,
                  color: Colors.grey[300],
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Clase que extiende 'SearchDelegate' para implementar la funcionalidad de búsqueda.
class AnimeSearchDelegate extends SearchDelegate<List<AnimeNode>> {
  // Lista de animes que coincide con la búsqueda.
  Iterable<Anime> animes = [];

  // Realiza una búsqueda de animes mediante la API.
  Future searchAnime(String query) async {
    final animes = await getAnimesbySearchApi(query: query); // Llama a la API.
    this.animes = animes.toList(); // Asigna los resultados a la lista.
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Botón de acción para borrar el texto de búsqueda.
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia el texto de búsqueda.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Botón de regreso para cerrar el cuadro de búsqueda.
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context,
            []); // Cierra el cuadro de búsqueda y devuelve una lista vacía.
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Construye los resultados basados en la consulta actual.
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Muestra resultados basados en la consulta mientras el usuario escribe.
    searchAnime(query);
    return _buildSearchResults(context);
  }

  // Construye la vista de resultados.
  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      // Si no hay texto de búsqueda, muestra un mensaje orientativo.
      return const Center(
        child: Text('Enter search query'),
      );
    } else {
      // Realiza la búsqueda y construye una lista de resultados.
      return FutureBuilder<Iterable<Anime>>(
        future: getAnimesbySearchApi(
            query: query), // Llama a la API con la consulta.
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los resultados.
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si la búsqueda falla.
            return Center(
              child: Text('Error: ${snapshot.error}'), // Detalle del error.
            );
          } else {
            // Muestra los resultados de búsqueda.
            final animes = snapshot.data ?? [];
            return SearchResultsView(animes: animes);
          }
        },
      );
    }
  }
}

// Vista para mostrar los resultados de búsqueda en un formato de lista.
class SearchResultsView extends StatelessWidget {
  const SearchResultsView({
    super.key,
    required this.animes,
  });

  final Iterable<Anime> animes; // Lista de animes a mostrar.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index); // Obtiene el anime actual.

          return AnimeListTile(
            anime: anime, // Muestra un componente de lista para cada anime.
          );
        },
      ),
    );
  }
}
