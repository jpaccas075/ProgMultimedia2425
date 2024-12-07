import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'package:drawer/screens/screens.dart';

class AppRoutes {
  // Define nombres para las rutas
  static const String home = '/';
  static const String name = '/name';
  static const String rowPhotos = '/rowPhotos';
  static const String columnPhotos = '/columnPhotos';
  static const String icons = '/icons';
  static const String challenge = '/challenge';
  static const String disposition = '/disposition';
  static const String counter = '/counter';
  static const String instagram = '/instagram';
  static const String game = '/game';
  static const String sieteYMedia = '/sieteYMedia';
  static const String formulario = '/formulario';

  // Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    name: (context) => const NameScreen(),
    rowPhotos: (context) => const RowPhotosScreen(),
    columnPhotos: (context) => const ColumnPhotosScreen(),
    icons: (context) => const IconsScreen(),
    challenge: (context) => const ChallengeScreen(),
    disposition: (context) => const DispositionScreen(),
    counter: (context) => const CounterScreen(),
    instagram: (context) => const MyHomePage(),
    game: (context) => const GameScreen(),
    sieteYMedia: (context) => const SieteYMediaGame(),
    formulario: (context) => const Formulario(),
  };
}