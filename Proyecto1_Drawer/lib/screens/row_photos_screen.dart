import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';

class RowPhotosScreen extends StatelessWidget {
  const RowPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotos en Fila'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/images/bird.png',
                width: 100,
                height: 100),
            Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100),
            const Padding(padding: EdgeInsets.only(left: 8.0)),
            Image.asset(
                'assets/images/unnamed.png',
                width: 100,
                height: 100),
          ],
        ),
      ),
    );
  }
}
