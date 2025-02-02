import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/config/theme/app_theme.dart';
import '/cubits/anime_title_language_cubit.dart';
import '/cubits/theme_cubit.dart';
import '/models/note.dart';
import '/screens/splash_screen.dart';

void main() async {
  // Inicializar Hive.
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  // Abrir el box de notas.
  await Hive.openBox<Note>('notes');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Proveedor para manejar el tema de la aplicación (modo claro/oscuro).
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        // Proveedor para manejar el idioma del título del anime.
        BlocProvider(
          create: (context) => AnimeTitleLanguageCubit(),
        ),
      ],
      // 'BlocBuilder' se encarga de reconstruir la UI cada vez que el estado de 'ThemeCubit' cambie.
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          final themeMode = state; // Obtiene el estado actual del tema.
          return MaterialApp(
            themeMode:
                themeMode, // Establece el 'themeMode' (puede ser claro u oscuro).
            theme:
                AppTheme.lightTheme, // Define el tema claro de la aplicación.
            darkTheme:
                AppTheme.darkTheme, // Define el tema oscuro de la aplicación.
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
