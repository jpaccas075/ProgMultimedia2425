class Carta {
  final String palo; // 'oros', 'copas', 'espadas', 'bastos'
  final int valor; // 1 al 7, 10 (sota), 11 (caballo), 12 (rey)

  Carta({required this.palo, required this.valor});

  double get valorCarta {
    if (valor >= 10) return 0.5; // Las figuras valen 0.5
    return valor.toDouble();
  }

  String get descripcion {
    String nombreValor;
    if (valor == 1) {
      nombreValor = "As";
    } else if (valor == 10) {
      nombreValor = "Sota";
    } else if (valor == 11) {
      nombreValor = "Caballo";
    } else if (valor == 12) {
      nombreValor = "Rey";
    } else {
      nombreValor = "$valor";
    }

    return "$nombreValor de ${palo[0].toUpperCase()}${palo.substring(1)}";
  }

  String get rutaImagen {
    return "assets/images/$palo$valor.jpg";
  }
}
