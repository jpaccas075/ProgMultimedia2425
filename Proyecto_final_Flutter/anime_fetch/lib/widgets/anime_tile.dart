import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/common/styles/text_styles.dart';
import '/models/anime_node.dart';
import '/screens/anime_details_screen.dart';

// Widget que representa un "tile" o celda que muestra la información de un anime.
class AnimeTile extends StatelessWidget {
  const AnimeTile({super.key, required this.anime});

  final AnimeNode anime; // El anime que se mostrará en el tile.

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(id: anime.id),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del anime con bordes redondeados.
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: anime.mainPicture.medium,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(height: 10),
            // Título del anime.
            Text(
              anime.title,
              maxLines: 3, // Limita el título a un máximo de 3 líneas.
              style: TextStyles.mediumText, // Estilo de texto personalizado.
              overflow: TextOverflow
                  .ellipsis, // Muestra '...' si el texto se desborda.
            ),
          ],
        ),
      ),
    );
  }
}
