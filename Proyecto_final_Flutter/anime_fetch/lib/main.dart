import 'package:flutter/material.dart';

import '/config/theme/app_theme.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Define el tema claro de la aplicación (por implementar).
      darkTheme: AppTheme.darkTheme, // Define el tema oscuro de la aplicación (por implementar).
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
