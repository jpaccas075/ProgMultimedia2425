import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/constants/app_colors.dart';
import '/models/anime.dart';
import '/screens/anime_details_screen.dart';

// Widget que muestra un carrusel de imágenes con los animes más populares.
class TopAnimesImageSlider extends StatefulWidget {
  const TopAnimesImageSlider({
    super.key,
    required this.animes,
  });

  final Iterable<Anime> animes; // Lista de animes.

  @override
  State<TopAnimesImageSlider> createState() => _TopAnimesImageSliderState();
}

class _TopAnimesImageSliderState extends State<TopAnimesImageSlider> {
  int _currentPageIndex =
      0; // Variable que guarda el índice de la página actual del carrusel.
  final CarouselSliderController _controller =
      CarouselSliderController(); // Controlador para manipular el carrusel.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Crea el carrusel con las imágenes de los animes.
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount:
                widget.animes.length, // Número de elementos en el carrusel.
            itemBuilder: (context, index, realIndex) {
              // Obtiene el anime en el índice actual.
              final anime = widget.animes.elementAt(index);
              // Muestra la imagen del anime.
              return TopAnimePicture(
                anime: anime,
              );
            },
            options: CarouselOptions(
              enlargeFactor: 0.22, // Factor de ampliación de la imagen.
              // Acción cuando cambia la página.
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              aspectRatio: 16 / 9,
              viewportFraction: 0.88, // Define el área visible de la página.
              autoPlay: true,
              enlargeCenterPage: true, // Enfoca la imagen central.
              initialPage: _currentPageIndex,
            ),
          ),
          const SizedBox(
              height: 20), // Espaciado entre el carrusel y el indicador.
          // Indicador de página para mostrar la página actual del carrusel.
          AnimatedSmoothIndicator(
            activeIndex: _currentPageIndex,
            count: widget.animes.length,
            // Efecto para personalizar el indicador.
            effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  rotationAngle: 180,
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.blueColor,
                  width: 28.0,
                  height: 8.0,
                ),
                dotDecoration: DotDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  width: 28.0,
                  height: 8.0,
                  color: Theme.of(context).primaryColor,
                )),
          )
        ],
      ),
    );
  }
}

// Widget para mostrar la imagen de cada anime en el carrusel.
class TopAnimePicture extends StatelessWidget {
  const TopAnimePicture({
    super.key,
    required this.anime,
  });

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Al tocar la imagen, navega a la pantalla de detalles del anime.
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AnimeDetailsScreen(id: anime.node.id),
        ));
      },
      splashColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            anime.node.mainPicture.medium,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
