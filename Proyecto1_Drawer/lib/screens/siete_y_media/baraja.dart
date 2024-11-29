import 'carta.dart';

List<Carta> generarBaraja() {
  List<Carta> baraja = [];
  const palos = ['oros', 'copas', 'espadas', 'bastos'];

  for (String palo in palos) {
    for (int valor = 1; valor <= 12; valor++) {
      if (valor != 8 && valor != 9) {
        // Excluir 8 y 9
        baraja.add(Carta(palo: palo, valor: valor));
      }
    }
  }
  baraja.shuffle();
  return baraja;
}
