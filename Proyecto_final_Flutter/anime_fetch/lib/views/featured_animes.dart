import 'package:flutter/material.dart';

import '/api/get_anime_by_ranking.dart';
import '/core/screens/error_screen.dart';
import '/core/widgets/loader.dart';
import '/screens/view_all_animes_screen.dart';
import '/widgets/anime_tile.dart';

// Widget que muestra una sección con animes destacados.
class FeaturedAnimes extends StatelessWidget {
  const FeaturedAnimes(
      {super.key, required this.rankingType, required this.label});

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    // FutureBuilder se usa para esperar a que los datos de la llamada a la API se obtengan.
    return FutureBuilder(
      future: getAnimeByRankingTypeApi(rankingType: rankingType, limit: 10),
      builder: (context, snapshot) {
        // Si la conexión está en espera, muestra un indicador de carga.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        // Si la respuesta es exitosa y contiene datos, se procesan los animes.
        if (snapshot.data != null) {
          final animes = snapshot.data;

          return Column(
            children: [
              // Título de la sección.
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Botón que lleva a la pantalla con todos los animes.
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewAllAnimesScreen(
                                rankingType: rankingType, label: label),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),

              // Lista horizontal que muestra los animes.
              SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal, // Lista horizontal.
                  shrinkWrap: true,
                  itemCount: animes!.length,
                  separatorBuilder: (context, index) {
                    // Espaciado entre los elementos de la lista.
                    return SizedBox(width: 10);
                  },
                  itemBuilder: (context, index) {
                    // Por cada anime, crea un widget AnimeTile para mostrarlo.
                    final anime = animes.elementAt(index);

                    return AnimeTile(
                      anime: anime.node,
                    );
                  },
                ),
              ),
            ],
          );
        }

        // Si hubo un error en la obtención de los datos, muestra una pantalla de error.
        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
