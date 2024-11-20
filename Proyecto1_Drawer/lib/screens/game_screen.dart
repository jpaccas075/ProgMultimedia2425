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
  int elementosNoPulsados = 0; // Contador de elementos no pulsados
  bool juegoPausado = false; // Indica si el juego está pausado

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
    if (juegoPausado) return; // No iniciar una nueva ronda si el juego está pausado
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
      imagenSeleccionada = imagenes[random.nextInt(imagenes.length)]; // Selecciona una imagen aleatoria
    });
    
    // Inicia el temporizador
    _temporizador = Timer(Duration(milliseconds: limiteTiempo), () {
      if (muestraImagen) {
        setState(() {
          puntuacion = (puntuacion - 2 < 0) ? 0 : puntuacion - 2; // Verifica que la puntuación no sea negativa
          muestraImagen = false; // Esconde la imagen después de que pase el tiempo
          elementosNoPulsados += 1; // Incrementa el contador de elementos no pulsados

          // Si no se han pulsado 3 elementos de manera consecutiva, se informa
          if (elementosNoPulsados == 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(
                  child: Text(
                    '¡Muy lento, dejaste escapar a 3 bichos seguidos!',
                  ),
                ),
                duration: Duration(seconds: 1),
              ),
            );
            elementosNoPulsados = 0; // Reinicia el contador de elementos no pulsados
          }
        });
        iniciarNuevaRonda(); // Inicia una nueva ronda
      }
    });
  }

  // Función que se llama cuando se toca la imagen
  void imagenPulsada() {
    if (muestraImagen && !juegoPausado) {
      setState(() {
        puntuacion += 1; // Suma 1 punto si se toca la imagen
        muestraImagen = false; // Esconde la imagen después de tocarla
        elementosNoPulsados = 0; // Reinicia el contador de elementos no pulsados
      });

      // Si la puntuación es un múltiplo de 10, se informa
      if (puntuacion % 10 == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('¡Genial, llevas $puntuacion puntos!')),
            duration: const Duration(seconds: 1),
          ),
        );
      }

      // Si la puntuación llega a 25 se muestra un diálogo
      if (puntuacion == 25) {
        _mostrarDialogoFelicitacion(context);
      } else {
        iniciarNuevaRonda(); // Inicia una nueva ronda
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gotta catch \'em all!'),
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
              left: 115,
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

// Función para mostrar el diálogo de felicitación
  Future<void> _mostrarDialogoFelicitacion(BuildContext context) async {
    setState(() {
      juegoPausado = true; // Pausa el juego
    });

    final respuesta = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Felicidades!', textAlign: TextAlign.center),
          content:
              const Text('¡Has alcanzado 25 puntos! ¿Te está gustando el juego?', textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Center(child: Text('Sí, por ahora bien')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Center(child: Text('No, menuda porquería')),
            ),
          ],
        );
      },
    );

    // Muestra un SnackBar según la respuesta
    if (respuesta == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              '¡Gracias! Puedes continuar jugando entonces. 😊',
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (respuesta == false) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              '😢😢😢😢😢',
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      juegoPausado = false;
    });

    iniciarNuevaRonda(); // Reanuda el juego al cerrar el diálogo
  }
}
