import 'package:flutter/material.dart';

class SeccionInferior extends StatefulWidget {
  const SeccionInferior({super.key});

  @override
  State<SeccionInferior> createState() => _SeccionInferiorState();
}

class _SeccionInferiorState extends State<SeccionInferior> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // Imágenes circulares situadas en el centro de la pantalla
      // Modificado para hacerlo con un ListView dispuesto en horizontal
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                construyeColumna('assets/images/nuevo.jpg', "Nuevo"),
                const SizedBox(width: 12),
                construyeColumna('assets/images/piloto.png', "Pilotando"),
                const SizedBox(width: 12),
                construyeColumna('assets/images/praga.jpg', "Praga y Bu..."),
                const SizedBox(width: 12),
                construyeColumna(
                    'assets/images/arquitectura.jpg', "Arquitectura"),
                const SizedBox(width: 12),
                construyeColumna('assets/images/dali.jpg', "Retratos"),
                const SizedBox(width: 12),
                construyeColumna('assets/images/jarl.jpg', "Fistro!"),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 260,
            child: DefaultTabController(
              length: 3, // Tres pestañas
              child: Column(
                children: [
                  // TabBar para cambiar entre las vistas
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on_rounded, size: 30)),
                      Tab(icon: Icon(Icons.person_pin_rounded, size: 30)),
                      Tab(icon: Icon(Icons.book_rounded, size: 30)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // TabBarView para mostrar el contenido dinámico
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Primera pestaña: Grid de imágenes
                        GridView.count(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 3,
                          children: List.generate(9, (index) {
                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                'assets/images/grid${index + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                        ),
                        // Segunda pestaña: Imagen "Time to Relax"
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/relax.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Tercera pestaña: Extracto Don Quijote
                        const SingleChildScrollView(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            '''En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga antigua, rocín flaco y galgo corredor.\n\nUna olla de algo más vaca que carnero, salpicón las más noches, duelos y quebrantos los sábados, lantejas los viernes, algún palomino de añadidura los domingos, consumían las tres partes de su hacienda.\n\nEl resto della concluían sayo de velarte, calzas de velludo para las fiestas, con sus pantuflos de lo mesmo, y los días de entresemana se honraba con su vellorí de lo más fino.''',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Iconos footer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(Icons.home_rounded, size: 40),
            const Icon(Icons.search_rounded, size: 40),
            const Icon(Icons.add_circle, size: 40),
            const Icon(Icons.favorite_rounded, size: 40),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                image: const DecorationImage(
                  image: AssetImage('assets/images/retrato.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Método para construir una columna con una imagen y un texto debajo
Widget construyeColumna(String rutaImagen, String texto) {
  return Column(
    children: [
      Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          image: DecorationImage(
            image: AssetImage(rutaImagen),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
      const SizedBox(height: 1),
      Text(
        texto,
        style: const TextStyle(fontSize: 13),
      ),
    ],
  );
}
