import 'package:flutter/material.dart';

import '/common/styles/paddings.dart';
import '/views/featured_animes.dart';
import '/widgets/top_animes_widget.dart';

// Pantalla que muestra diferentes categorías de animes organizadas en secciones.
class AnimesScreen extends StatefulWidget {
  const AnimesScreen({super.key});

  @override
  State<AnimesScreen> createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimeFetch'),
        centerTitle: true,
        actions: [
          // Botón de búsqueda en la barra superior.
          IconButton(
            onPressed:
                () {}, // Acción al presionar el botón (actualmente sin implementar).
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección "Featured Animes" (animes destacados).
            SizedBox(
              height: 300,
              child: TopAnimesList(), // Lista de animes destacados.
            ),

            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  // Bloques de diferentes categorías de animes.
                  // Animes mejor valorados.
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Ranked',
                      rankingType: 'all',
                    ),
                  ),

                  // Animes más populares.
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Popular',
                      rankingType: 'bypopularity',
                    ),
                  ),

                  // Mejores películas.
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Movies',
                      rankingType: 'movie',
                    ),
                  ),

                  // Animes favoritos.
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Favorited',
                      rankingType: 'favorite',
                    ),
                  ),

                  // Animes próximos a estrenarse.
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Upcoming',
                      rankingType: 'upcoming',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
