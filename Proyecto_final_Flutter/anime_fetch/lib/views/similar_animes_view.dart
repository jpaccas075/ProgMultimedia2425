import 'package:flutter/material.dart';

import '/models/anime_node.dart';
import '/screens/anime_details_screen.dart';
import '/widgets/anime_tile.dart';

// Widget que muestra una lista de animes similares mediante un ListView horizontal.
class SimilarAnimesView extends StatelessWidget {
  const SimilarAnimesView(
      {super.key, required this.animes, required this.label});

  final List<AnimeNode> animes;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parte del título.
        SizedBox(
          height: 50,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Lista de animes similares.
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: animes.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final anime = animes.elementAt(index);

              return InkWell(
                onTap: () {
                  // Al hacer clic en el anime, navega a la pantalla de detalles.
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AnimeDetailsScreen(id: anime.id),
                    ),
                  );
                },
                // Muestra el widget AnimeTile que representa cada anime.
                child: AnimeTile(
                  anime: anime,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
