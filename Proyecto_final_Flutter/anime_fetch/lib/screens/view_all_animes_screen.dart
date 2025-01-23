import 'package:flutter/material.dart';

import '/api/get_anime_by_ranking.dart';
import '/core/screens/error_screen.dart';
import '/core/widgets/loader.dart';
import '/views/ranked_animes_list_view.dart';

// Pantalla que muestra una lista de animes según un tipo de ranking.
class ViewAllAnimesScreen extends StatelessWidget {
  const ViewAllAnimesScreen(
      {super.key, required this.rankingType, required this.label});

  final String
      rankingType; // Define el tipo de ranking para filtrar los animes.
  final String label; // Título de la pantalla, que describe el contenido.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: FutureBuilder(
        future: getAnimeByRankingTypeApi(rankingType: rankingType, limit: 500),
        // Llama a la API para obtener una lista de animes según el ranking especificado.
        builder: (context, snapshot) {
          // Muestra un indicador de carga mientras se espera la respuesta de la API.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          // Verifica si se han recibido datos válidos.
          if (snapshot.data != null) {
            return RankedAnimesListView(
              animes: snapshot.data!, // Renderiza la lista de animes recibidos.
            );
          }

          // Muestra un mensaje de error en caso de que la API falle o no devuelva datos.
          return ErrorScreen(error: snapshot.error.toString());
        },
      ),
    );
  }
}
