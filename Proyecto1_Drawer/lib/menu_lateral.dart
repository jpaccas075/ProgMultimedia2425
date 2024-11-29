import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Elimina el padding predeterminado
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Software Society Inc."),
            accountEmail: Text("jpaccas075@g.educaand.es"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://st2.depositphotos.com/1718692/5917/i/450/depositphotos_59179351-stock-photo-pine-forest-near-the-mountain.jpg"),
                    fit: BoxFit
                        .cover)), // Ajusta la imagen para cubrir todo el espacio
          ),
          Ink(
            color: Colors.indigo[400],
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Nombre y Apellidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.name);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Fotos en Fila'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.rowPhotos);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Fotos en Columna'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.columnPhotos);
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Iconos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.icons);
            },
          ),
          ListTile(
            leading: const Icon(Icons.stadium),
            title: const Text('Reto'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.challenge);
            },
          ),
          ListTile(
            leading: const Icon(Icons.park_outlined),
            title: const Text('Disposición'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.disposition);
            },
          ),
          ListTile(
            leading: const Icon(Icons.replay_circle_filled_rounded),
            title: const Text('Contador'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.counter);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_rounded),
            title: const Text('Instagram'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.instagram);
            },
          ),
          ListTile(
            leading: const Icon(Icons.gamepad_rounded),
            title: const Text('Juego'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.game);
            },
          ),
          ListTile(
            leading: const Icon(Icons.casino_rounded),
            title: const Text('Siete y media'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.sieteYMedia);
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto Drawer'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Selecciona una opción del menú'),
      ),
    );
  }
}
