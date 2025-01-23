import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/models/anime.dart';
import '/screens/anime_details_screen.dart';

// Muestra la lista de animes en una grill tipo masonry (con elementos de diferentes tamaños).
class AnimesGridList extends StatelessWidget {
  const AnimesGridList({
    super.key,
    required this.title,
    required this.animes,
  });

  final String title;
  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    // Se usa MasonryGridView para crear una grill con animes de diferente altura.
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime =
            animes.elementAt(index); // Obtiene el anime en la posición index.

        // Devuelve un widget para cada anime en la grill.
        return AnimeGridTile(anime: anime);
      },
    );
  }
}

// Widget para cada celda de la grill.
class AnimeGridTile extends StatelessWidget {
  const AnimeGridTile({
    super.key,
    required this.anime,
  });

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Cuando el usuario hace clic en la celda, navega a la pantalla de detalles del anime.
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(id: anime.node.id),
          ),
        );
      },
      child: Material(
        elevation: 5,
        child: CachedNetworkImage(
          imageUrl: anime.node.mainPicture
              .medium, // Usa la URL de la imagen principal del anime.
          fit: BoxFit
              .fitWidth, // Ajusta la imagen para que se ajuste al ancho de la celda.
        ),
      ),
    );
  }
}
