import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/styles/paddings.dart';
import '/cubits/anime_title_language_cubit.dart';
import '/cubits/theme_cubit.dart';

// Pantalla de configuración que permite a los usuarios cambiar el tema de la aplicación
// y el idioma de los títulos de los animes. El botón 'Credits' se usa para mostrar los créditos de la aplicación.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final double buttonElevation = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ThemeSwitchWidget(), // Widget para cambiar entre modo claro y oscuro.
            const SizedBox(height: 20),
            const AnimeTitleLanguageSwitch(), // Widget para cambiar el idioma de los títulos de anime.
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 300,
                child: BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                  final isDarkMode = themeMode == ThemeMode.dark;
                  return ElevatedButton(
                    onPressed: () => _showCreditsDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDarkMode ? Colors.grey[800] : Colors.blue[400],
                      foregroundColor: isDarkMode ? Colors.white : Colors.white,
                      elevation: buttonElevation,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Credits',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Muestra un cuadro de diálogo modal en pantalla.
void _showCreditsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // No permite cerrar el diálogo tocando fuera de él.
    builder: (BuildContext context) {
      // Se obtiene el color de fondo para el diálogo basado en el tema actual de la aplicación.
      final backgroundColor = Theme.of(context).dialogBackgroundColor;
      // Determina el color del texto del botón 'OK' dependiendo del tema actual.
      final buttonTextColor = Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

      return AlertDialog(
        title: const Text('App Credits', textAlign: TextAlign.center),
        content: const Text(
          'Developer: \n'
          'Jorge Pacheco Castro\n\n'
          'Special Thanks: \n'
          'MyAnimeList Team\n\n'
          'Copyright: \n'
          '© 2025 AnimeFetch. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: backgroundColor,
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Widget que permite cambiar entre modo claro y oscuro.
class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isDarkMode = false;

  // Cambia el estado del tema de la aplicación (claro/oscuro).
  Future<void> toggleDarkMode(value) async {
    setState(() => isDarkMode = !isDarkMode); // Actualiza el estado local.
    context.read<ThemeCubit>().changeTheme(isDarkMode: isDarkMode);
    // Notifica al cubit para actualizar el tema global de la aplicación.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Dark Mode Enabled'),
        // Escucha el estado del ThemeCubit para reflejar cambios en tiempo real.
        BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
          isDarkMode = state ==
              ThemeMode
                  .dark; // Sincroniza el estado local con el estado del cubit.
          return CupertinoSwitch(
            value: isDarkMode, // Define el estado inicial del interruptor.
            onChanged: toggleDarkMode, // Acción al cambiar el interruptor.
          );
        }),
      ],
    );
  }
}

// Widget que permite cambiar el idioma de los títulos de los animes.
class AnimeTitleLanguageSwitch extends StatefulWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  State<AnimeTitleLanguageSwitch> createState() =>
      _AnimeTitleLanguageSwitchState();
}

class _AnimeTitleLanguageSwitchState extends State<AnimeTitleLanguageSwitch> {
  bool isEnglish = false;

  // Cambia el idioma de los títulos de anime.
  Future<void> toggleAnimeTitleLanguage(_) async {
    setState(() => isEnglish = !isEnglish); // Actualiza el estado local.
    context
        .read<AnimeTitleLanguageCubit>()
        .changeAnimeTitleLanguage(isEnglish: isEnglish);
    // Notifica al cubit para actualizar el idioma de los títulos globalmente.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('English Titles Enabled'),
        // Escucha el estado del AnimeTitleLanguageCubit para reflejar cambios en tiempo real.
        BlocBuilder<AnimeTitleLanguageCubit, bool>(builder: (context, state) {
          isEnglish =
              state; // Sincroniza el estado local con el estado del cubit.
          return CupertinoSwitch(
            value: isEnglish, // Define el estado inicial del interruptor.
            onChanged:
                toggleAnimeTitleLanguage, // Acción al cambiar el interruptor.
          );
        }),
      ],
    );
  }
}
