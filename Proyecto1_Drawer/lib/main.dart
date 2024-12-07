import 'package:flutter/material.dart';
// Rutas en fichero externo
import 'routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario de la aplicación
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejercicio Drawer',
      theme: ThemeData(
          // Theme personalizado
          scaffoldBackgroundColor: Colors.amberAccent[100],
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 10.0,
              shadowColor: Colors.black.withOpacity(1)),
          textTheme: const TextTheme(
              titleLarge:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      locale: const Locale('es', 'ES'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'ES')],
    );
  }
}
