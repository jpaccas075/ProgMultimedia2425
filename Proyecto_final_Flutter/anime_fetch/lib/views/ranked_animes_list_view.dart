import 'package:flutter/material.dart';

import '/common/styles/paddings.dart';
import '/models/anime.dart';
import '/widgets/anime_list_tile.dart';

// Widget que muestra una lista de animes clasificados.
class RankedAnimesListView extends StatelessWidget {
  const RankedAnimesListView({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings
          .defaultPadding, // Aplica padding definido en el archivo de estilos.
      child: ListView.builder(
        // ListView.builder para construir la lista de animes.
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(
              index); // Obtiene el anime en el índice correspondiente.

          return AnimeListTile(
            // Crea un tile para cada anime.
            anime: anime,
          );
        },
      ),
    );
  }
}
