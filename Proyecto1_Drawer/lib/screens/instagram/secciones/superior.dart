import 'package:flutter/material.dart';

AppBar obtieneAppBar() {
  return AppBar(
    title: const Row(
      children: [
        Text('alvarezdelvayo'),
        Icon(Icons.keyboard_arrow_down_rounded),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
    ],
  );
}

class SeccionSuperior extends StatelessWidget {
  const SeccionSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45), // Redondea la imagen
                  image: const DecorationImage(
                    image: AssetImage('assets/images/retrato.jpg'),
                    fit: BoxFit.cover, // Para que la imagen cubra todo el área
                  ),
                ),
              ),
            ],
          ),
          const Column(
            children: [
              Text("1.026",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Publicaciones"),
            ],
          ),
          const Column(
            children: [
              Text("859",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Seguidores"),
            ],
          ),
          const Column(
            children: [
              Text("211",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Seguidos"),
            ],
          ),
        ],
      ),
    );
  }
}
