// Extensión para convertir un valor entero (segundos) a minutos.
extension ConvertToMinute on int {
  String toMinute() {
    int inMinute = this ~/ 60;
    return '$inMinute mins';
  }
}
