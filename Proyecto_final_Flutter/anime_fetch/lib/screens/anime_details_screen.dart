import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/api/get_anime_details.dart';
import '/common/extensions/extensions.dart';
import '/common/styles/paddings.dart';
import '/common/styles/text_styles.dart';
import '/common/widgets/ios_back_button.dart';
import '/common/widgets/network_image_view.dart';
import '/common/widgets/read_more_text.dart';
import '/core/screens/error_screen.dart';
import '/core/widgets/loader.dart';
import '/models/anime_details.dart';
import '/models/picture.dart';
import '/views/similar_animes_view.dart';
import '/widgets/info_text.dart';

// Pantalla para mostrar información específica sobre un anime.
class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({super.key, required this.id});

  final int id; // ID del anime que se utiliza para obtener sus detalles.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeDetailsApi(
          id: id), // Llama a la API para obtener detalles del anime.
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se obtienen los datos.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        // Si hay datos disponibles, se procesan.
        if (snapshot.data != null) {
          final anime = snapshot.data;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Muestra la imagen principal del anime.
                  _buildAnimeImageWidget(
                    imageUrl: anime!.mainPicture.large,
                  ),

                  Padding(
                    padding: Paddings.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título del anime.
                        _buildAnimeTitle(
                          name: anime.title,
                          englishName: anime.alternativeTitles.en,
                        ),

                        const SizedBox(height: 20),

                        // Descripción del anime con soporte para texto expandible.
                        ReadMoreText(longText: anime.synopsis),

                        const SizedBox(height: 10),

                        // Información general del anime como géneros, duración, etc.
                        _buildAnimeInfo(
                          anime: anime,
                        ),

                        const SizedBox(height: 20),

                        // Antecedentes del anime, si están disponibles.
                        anime.background.isNotEmpty
                            ? _buildAnimeBackground(
                                background: anime.background)
                            : const SizedBox
                                .shrink(), // Espacio vacío si no hay antecedentes.

                        const SizedBox(height: 20),

                        // Galería de imágenes relacionadas con el anime.
                        _buildImageGallery(images: anime.pictures),

                        const SizedBox(height: 20),

                        // Animes relacionados con el actual.
                        SimilarAnimesView(
                            animes: anime.relatedAnime
                                .map((relatedAnime) => relatedAnime.node)
                                .toList(),
                            label: 'Related Anime'),

                        const SizedBox(height: 20),

                        // Recomendaciones de otros animes.
                        SimilarAnimesView(
                            animes: anime.recommendations
                                .map((animeRec) => animeRec.node)
                                .toList(),
                            label: 'Recommendations'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        // Muestra un error si ocurre un problema al cargar los datos.
        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }

  // Muestra la imagen destacada del anime.
  _buildAnimeImageWidget({
    required String imageUrl,
  }) =>
      Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 400,
            width: double.infinity, // Ancho para cubrir toda la pantalla.
          ),
          // Botón de retroceso posicionado sobre la imagen.
          Positioned(
            top: 30,
            left: 20,
            child: Builder(
              builder: (context) {
                return IosBackButton(
                  onPressed: Navigator.of(context).pop, // Navega hacia atrás.
                );
              },
            ),
          ),
        ],
      );

  // Construye el título del anime.
  Widget _buildAnimeTitle({
    required String name,
    required String englishName,
  }) =>
      Builder(
        builder: (context) {
          return Text(
            englishName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      );

  // Construye una lista de información clave sobre el anime.
  Widget _buildAnimeInfo({
    required AnimeDetails anime,
  }) {
    // Convierte listas como estudios y géneros en cadenas separadas por comas.
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otherNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres: ', info: genres),
        InfoText(label: 'Start date: ', info: anime.startDate),
        InfoText(label: 'End date: ', info: anime.endDate),
        InfoText(label: 'Episodes: ', info: anime.numEpisodes.toString()),
        InfoText(
          label: 'Average Episode Duration: ',
          info: anime.averageEpisodeDuration
              .toMinute(), // Convierte segundos a minutos.
        ),
        InfoText(label: 'Status: ', info: anime.status),
        InfoText(label: 'Rating: ', info: anime.rating),
        InfoText(label: 'Studios: ', info: studios),
        InfoText(label: 'Other Names: ', info: otherNames),
        InfoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InfoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  // Muestra el texto de antecedentes del anime.
  Widget _buildAnimeBackground({
    required String background,
  }) {
    return WhiteContainer(
      child: Text(
        background,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  // Construye una galería de imágenes relacionadas con el anime.
  Widget _buildImageGallery({
    required List<Picture> images,
  }) {
    return Column(
      children: [
        Text(
          'Image Gallery',
          style: TextStyles.mediumText,
        ),
        GridView.builder(
          itemCount: images.length,
          shrinkWrap: true, // Ajusta el tamaño del grid al contenido.
          physics:
              NeverScrollableScrollPhysics(), // Evita el desplazamiento interno.
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columnas en la cuadrícula.
              childAspectRatio: 9 / 16, // Relación de aspecto de las imágenes.
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            final image = images[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NetworkImageView(
                          imageUrl: image
                              .large), // Pantalla de visualización de imagen.
                    ),
                  );
                },
                child: Image.network(
                  image.medium,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Contenedor con estilo blanco y sombra para consistencia visual.
class WhiteContainer extends StatelessWidget {
  const WhiteContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // Sombra para dar efecto de elevación.
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
