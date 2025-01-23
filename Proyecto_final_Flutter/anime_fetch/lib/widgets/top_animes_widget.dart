import 'package:flutter/material.dart';

import '/api/get_anime_by_ranking.dart';
import '/core/screens/error_screen.dart';
import '/core/widgets/loader.dart';
import '/widgets/top_animes_image_slider.dart';

// Widget que muestra una lista de los animes más populares utilizando un carrusel de imágenes.
class TopAnimesList extends StatelessWidget {
  const TopAnimesList({super.key});

  @override
  Widget build(BuildContext context) {
    // Se usa FutureBuilder para obtener los datos de los animes desde la API.
    return FutureBuilder(
        future: getAnimeByRankingTypeApi(rankingType: 'all', limit: 6),
        builder: (context, snapshot) {
          // Mientras la API esté esperando la respuesta, muestra el widget de carga.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          // Si la respuesta de la API no es nula, muestra el carrusel.
          if (snapshot.data != null) {
            final animes = snapshot.data!
                .toList(); // Convierte los datos obtenidos en una lista de animes.
            // Devuelve el widget del carrusel con los animes obtenidos.
            return TopAnimesImageSlider(animes: animes);
          }

          // Si no se obtuvieron datos, muestra una pantalla de error.
          return ErrorScreen(error: snapshot.error.toString());
        });
  }
}
