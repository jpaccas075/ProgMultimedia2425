import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'dart:math';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int puntuacion = 0;
  bool muestraImagen = false;
  double ejeX = 100, ejeY = 100; // Posición inicial de la imagen
  late Timer _temporizador;
  int limiteTiempo = 1500; // Tiempo en milisegundos para tocar la imagen
  final Random random = Random();
  String imagenSeleccionada = '';
  final double alturaImagen = 110;

  // Lista de imágenes
  final List<String> imagenes = [
    'assets/images/pikachu.png',
    'assets/images/squirtle.png',
    'assets/images/charmander.png',
    'assets/images/bulbasaur.png',
    'assets/images/eevee.png',
    'assets/images/meowth.png',
    'assets/images/cunyao.png',
    'assets/images/perrete.png'
  ];

  @override
  void initState() {
    super.initState();
    _temporizador = Timer(const Duration(milliseconds: 0),
        () {}); // Inicializa con un temporizador ficticio
  }

  // Este método se llama inmediatamente después de initState() la primera vez que se compila el widget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iniciarNuevaRonda(); // Inicia una nueva ronda
  }

  @override
  void dispose() {
    _temporizador.cancel(); // Cancela el temporizador al salir de la pantalla
    super.dispose();
  }

  // Función que genera una nueva ronda
  void iniciarNuevaRonda() {
    // Cancela cualquier temporizador activo
    _temporizador.cancel();
    // Obtiene las dimensiones de la pantalla
    final anchoPantalla = MediaQuery.of(context).size.width;
    final altoPantalla = MediaQuery.of(context).size.height;
    // Delimita la zona de aparición
    const double minEjeY = 50; // Posición mínima en el eje Y (debajo del texto Puntuación)
    final double maxEjeY = altoPantalla - alturaImagen - 100;
    final double maxEjeX = anchoPantalla - 100;

    // Actualiza la posición de la imagen de manera aleatoria
    setState(() {
      ejeX = random.nextDouble() * maxEjeX;
      ejeY = minEjeY + random.nextDouble() * (maxEjeY - minEjeY);
      muestraImagen = true; // Muestra la imagen en la nueva posición
      imagenSeleccionada = imagenes[
          random.nextInt(imagenes.length)]; // Selecciona una imagen aleatoria
    });
    // Inicia el temporizador
    _temporizador = Timer(Duration(milliseconds: limiteTiempo), () {
      if (muestraImagen) {
        setState(() {
          puntuacion = (puntuacion - 2 < 0)
              ? 0
              : puntuacion - 2; // Verifica que la puntuación no sea negativa
          muestraImagen =
              false; // Esconde la imagen después de que pase el tiempo
        });
        iniciarNuevaRonda(); // Inicia una nueva ronda
      }
    });
  }

  // Función que se llama cuando se toca la imagen
  void imagenPulsada() {
    if (muestraImagen) {
      setState(() {
        puntuacion += 1; // Suma 1 punto si se toca la imagen
        muestraImagen = false; // Esconde la imagen después de tocarla
      });
      iniciarNuevaRonda(); // Inicia una nueva ronda
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Gotta catch \'em all!',
            style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        shadowColor: Colors.black.withOpacity(1),
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pattern2.png'),
                repeat: ImageRepeat.repeat)),
        child: Stack(
          children: [
            // Muestra la puntuación en la parte superior
            Positioned(
              top: 20,
              left: 100,
              child: Text(
                'Puntuación: $puntuacion',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Imagen que aparece en posición aleatoria
            if (muestraImagen)
              Positioned(
                left: ejeX,
                top: ejeY,
                child: GestureDetector(
                  onTap: imagenPulsada, // Acción al tocar la imagen
                  child: Image.asset(
                    imagenSeleccionada, // Imagen a tocar
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
