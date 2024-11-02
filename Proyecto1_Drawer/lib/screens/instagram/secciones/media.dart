import 'package:flutter/material.dart';

class SeccionMedia extends StatelessWidget {
  const SeccionMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fernando Álvarez del Vayo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("\"Nunca sabes lo que te depara el futuro\"."),
                  SizedBox(height: 4),
                  Text(
                    "faqsandroid.com/",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
          ),
          child: const Text("Editar perfil"),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
