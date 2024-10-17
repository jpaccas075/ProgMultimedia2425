import 'package:flutter/material.dart';

class SeccionInferior extends StatefulWidget {
  const SeccionInferior({super.key});

  @override
  State<SeccionInferior> createState() => _SeccionInferiorState();
}

class _SeccionInferiorState extends State<SeccionInferior> {
  bool muestraGrid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      // Imágenes circulares situadas en el centro de la pantalla
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/nuevo.jpg'),
                        ),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Nuevo",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/piloto.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Pilotando",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/praga.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Praga",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/arquitectura.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Arquitectura",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/dali.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Retratos",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Iconos clicables para cambiar el State y mostrar lo que haya en el mismo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.grid_on_rounded, size: 30),
              onPressed: () {
                setState(() {
                  muestraGrid = true;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_pin_sharp, size: 30),
              onPressed: () {
                setState(() {
                  muestraGrid = false;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Grid de imágenes/Imagen "time to relax" (lo que se muestra depende del valor de la variable muestraGrid)
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 220,
              child: muestraGrid
                  ? GridView.count(
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
                    )
                  : Center(
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
            )),
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
