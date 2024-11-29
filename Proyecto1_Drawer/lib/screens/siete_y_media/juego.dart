import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'baraja.dart';
import 'carta.dart';

class SieteYMediaGame extends StatefulWidget {
  const SieteYMediaGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SieteYMediaGameState createState() => _SieteYMediaGameState();
}

class _SieteYMediaGameState extends State<SieteYMediaGame> {
  List<Carta> baraja = [];
  List<Carta> manoJugador = [];
  List<Carta> manoMaquina = [];
  double puntuacionJugador = 0;
  double puntuacionMaquina = 0;
  int victoriasJugador = 0;
  int victoriasMaquina = 0;
  bool mostrarPuntuacionMaquina = false;

  @override
  void initState() {
    super.initState();
    reiniciarRonda();
  }

  void reiniciarRonda() {
    setState(() {
      baraja = generarBaraja();
      manoJugador = [];
      manoMaquina = [];
      puntuacionJugador = 0;
      puntuacionMaquina = 0;
      mostrarPuntuacionMaquina = false; // Oculta la puntuación de la máquina
    });
  }

  void _pedirCartaJugador() {
    if (baraja.isNotEmpty) {
      Carta carta = baraja.removeLast();
      setState(() {
        manoJugador.add(carta);
        puntuacionJugador += carta.valorCarta;
      });

      if (puntuacionJugador > 7.5) {
        _finalizarRonda("¡Te has pasado! Punto para la Máquina.");
        victoriasMaquina++;
      }
    }
  }

  void _jugarMaquina() {
    while (puntuacionMaquina < 6.5 &&
        puntuacionMaquina <= puntuacionJugador &&
        puntuacionMaquina < 7.5) {
      if (baraja.isNotEmpty) {
        Carta carta = baraja.removeLast();
        manoMaquina.add(carta);
        puntuacionMaquina += carta.valorCarta;
      }
    }

    setState(() {
      mostrarPuntuacionMaquina = true; // Revela la puntuación de la máquina
    });

    if (puntuacionMaquina > 7.5) {
      _finalizarRonda("¡La Máquina se pasó! Punto para ti.");
      victoriasJugador++;
    } else {
      _compararResultados();
    }
  }

  void _compararResultados() {
    if (puntuacionJugador > puntuacionMaquina) {
      victoriasJugador++;
      _finalizarRonda("¡Ganaste esta ronda!");
    } else if (puntuacionJugador < puntuacionMaquina) {
      victoriasMaquina++;
      _finalizarRonda("La Máquina ganó esta ronda.");
    } else {
      _finalizarRonda("¡Empate!");
    }
  }

  void _finalizarRonda(String mensaje) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que se cierre el dialog al hacer clic fuera
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Resultado de la Ronda",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        mensaje,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _verificarGanadorGlobal();
                        },
                        child: const Text(
                          "Siguiente Ronda",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _verificarGanadorGlobal() {
    if (victoriasJugador == 5) {
      _mostrarGanadorFinal("¡Felicidades! Ganaste el juego.");
    } else if (victoriasMaquina == 5) {
      _mostrarGanadorFinal("La Máquina ganó el juego. ¡Inténtalo de nuevo!");
    } else {
      reiniciarRonda();
    }
  }

  void _mostrarGanadorFinal(String mensaje) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Resultado Final", textAlign: TextAlign.center),
        content: Text(mensaje, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                victoriasJugador = 0;
                victoriasMaquina = 0;
                reiniciarRonda();
              });
            },
            child: const Center(child: Text("Reiniciar Juego")),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Siete y Media")),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pattern3.jpg'),
                repeat: ImageRepeat.repeat)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Victorias - Tú: $victoriasJugador | Máquina: $victoriasMaquina",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 20),
            Text("Tu puntuación: $puntuacionJugador",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(
                "Puntuación Máquina: ${mostrarPuntuacionMaquina ? puntuacionMaquina : '???'}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: manoJugador
                    .map((carta) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            carta.rutaImagen, // Carga la imagen de la carta
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      puntuacionJugador <= 7.5 ? _pedirCartaJugador : null,
                  child: const Text("Pedir Carta"),
                ),
                ElevatedButton(
                  onPressed: puntuacionJugador > 0 ? _jugarMaquina : null,
                  child: const Text("Plantarse"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
