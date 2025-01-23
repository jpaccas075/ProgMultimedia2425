import 'package:flutter/material.dart';

import '/api/get_anime_by_ranking.dart';
import '/core/screens/error_screen.dart';
import '/core/widgets/loader.dart';
import '/models/anime_category.dart';
import '/views/animes_grid_list.dart';

// Muestra una vista tipo grill con animes basados en la categoría seleccionada.
class AnimeGridView extends StatelessWidget {
  const AnimeGridView({super.key, required this.category});

  final AnimeCategory category;

  @override
  Widget build(BuildContext context) {
    // FutureBuilder para obtener los datos de los animes según el tipo de ranking de la categoría.
    return FutureBuilder(
      future: getAnimeByRankingTypeApi(
          rankingType: category.rankingType, limit: 100),
      builder: (context, snapshot) {
        // Si la conexión está en espera, muestra un indicador de carga.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        // Si los datos se han recibido correctamente, muestra la lista.
        if (snapshot.data != null) {
          final animes = snapshot.data;

          // Devuelve el widget de la grill de animes.
          return AnimesGridList(
            title: category.title,
            animes: animes!,
          );
        }

        // Si hubo un error en la obtención de los datos, muestra una pantalla de error.
        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
