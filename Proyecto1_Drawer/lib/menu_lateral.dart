import 'package:flutter/material.dart';
import 'package:drawer/screens/name_screen.dart';
import 'package:drawer/screens/row_photos_screen.dart';
import 'package:drawer/screens/column_photos_screen.dart';
import 'package:drawer/screens/icons_screen.dart';
import 'package:drawer/screens/challenge_screen.dart';
import 'package:drawer/screens/disposition_screen.dart';
import 'package:drawer/screens/counter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto Drawer'),
      ),
      drawer: Drawer(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NameScreen()),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Fotos en Fila'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RowPhotosScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Fotos en Columna'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ColumnPhotosScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Iconos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IconsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.stadium),
              title: const Text('Reto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChallengeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.park_outlined),
              title: const Text('Disposición'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DispositionScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.replay_circle_filled_rounded),
              title: const Text('Contador'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Selecciona una opción del menú'),
      ),
    );
  }
}
