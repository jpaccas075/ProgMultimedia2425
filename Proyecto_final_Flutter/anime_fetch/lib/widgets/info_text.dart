import 'package:flutter/material.dart';

// Widget que muestra un texto con dos partes: etiqueta (label) y valor (info).
class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.label, required this.info});

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: info,
          )
        ],
      ),
    );
  }
}
