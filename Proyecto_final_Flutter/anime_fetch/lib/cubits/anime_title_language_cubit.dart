import 'package:flutter_bloc/flutter_bloc.dart';

import '/database_helper/database_helper.dart';

// Clase que gestiona el estado del idioma de los títulos de los animes.
// Utiliza un tipo alias 'IsEnglish' como booleano para representar si el idioma es inglés o no.
typedef IsEnglish = bool;

class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
  // Constructor que inicializa el estado con 'false' (por defecto no está en inglés).
  AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }

  // Getter que retorna un valor booleano indicando si el idioma es inglés (si el estado es 'true').
  bool get isEnglish => state;

  // Método privado que obtiene el idioma actual del título del anime desde la base de datos.
  Future _fetchAnimeTitleLanguage() async {
    // Llama a la base de datos para obtener si el idioma es inglés o no y emite el valor correspondiente.
    final isEnglish = await DatabaseHelper.instance.isEnglish;
    emit(isEnglish);
  }

  // Método que cambia el idioma del título del anime y lo guarda en la base de datos.
  Future changeAnimeTitleLanguage({required bool isEnglish}) async {
    // Guarda la preferencia de idioma en la base de datos.
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    // Emite el nuevo estado con el valor proporcionado.
    emit(isEnglish);
  }
}
