import 'package:flutter/material.dart';

// Widget que muestra un texto largo y permite alternar entre ver más o ver menos.
class ReadMoreText extends StatefulWidget {
  const ReadMoreText({
    super.key,
    required this.longText,
  });

  // Texto que se va a mostrar en el widget.
  final String longText;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  // Variable que determina si el texto se muestra completo o truncado.
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          widget.longText, // Accede al texto desde el widget padre.
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
          ),
          maxLines: readMore ? 1000 : 5, // Si 'readMore' es verdadero, se muestran todas las líneas; si es falso, solo 5.
          overflow: TextOverflow.ellipsis, // Si el texto excede el número de líneas, se coloca un "..." al final.
        ),
        // Botón que permite alternar entre "Leer más" o "Leer menos".
        TextButton(
          onPressed: () {
            setState(() {
              // Al presionar el botón, se alterna el valor de 'readMore' y se actualiza la interfaz.
              readMore = !readMore;
            });
          },
          child: Text(readMore ? 'Read less' : 'Read more'), // El texto cambia según el estado de 'readMore'.
        ),
      ],
    );
  }
}
