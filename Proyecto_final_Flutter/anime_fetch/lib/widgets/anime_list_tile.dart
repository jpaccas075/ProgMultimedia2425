import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/models/anime.dart';
import '/screens/anime_details_screen.dart';

// Widget que representa un elemento de la lista de animes.
class AnimeListTile extends StatelessWidget {
  const AnimeListTile({
    super.key,
    required this.anime,
    this.rank,
  });

  final Anime anime; // Objeto que contiene los datos como título e imagen.
  final int? rank; // Ranking del anime, si está disponible.

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Detecta clics para navegar a la pantalla de detalles del anime.
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(id: anime.node.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(15), // Bordes redondeados del contenedor.
          child: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen del anime.
                SizedBox(
                  height: 100,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl:
                        anime.node.mainPicture.medium, // URL de la imagen.
                    fit: BoxFit
                        .cover, // Ajuste de la imagen dentro del contenedor.
                  ),
                ),

                const SizedBox(
                    width: 20), // Espaciado entre la imagen y el texto.

                // Información del anime.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Muestra el ranking si está disponible.
                      rank != null
                          ? AnimeRankBadge(rank: rank!)
                          : const SizedBox.shrink(),
                      const SizedBox(height: 10),
                      Text(
                        anime.node.title, // Título del anime.
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2, // Limita el título a 2 líneas.
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget que representa el "badge" del ranking del anime.
class AnimeRankBadge extends StatelessWidget {
  const AnimeRankBadge({
    super.key,
    required this.rank,
  });

  final int rank;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 3.0,
        ),
        child: Text(
          'Rank $rank',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
