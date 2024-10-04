import 'package:flutter/material.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iconos'),
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.home, size: 50),
            Icon(Icons.star, size: 50),
            Icon(Icons.settings, size: 50),
            Icon(Icons.phone, size: 50),
            Icon(Icons.map, size: 50),
          ],
        ),
      ),
    );
  }
}
