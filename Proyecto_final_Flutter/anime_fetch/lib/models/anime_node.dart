import 'package:flutter/foundation.dart';

import 'picture.dart';

// Esta clase encapsula información básica de un anime.
@immutable
class AnimeNode {
  final int id; // Identificador único del anime.
  final String title; // Título del anime.
  final Picture mainPicture; // Imagen principal asociada al anime, representada por la clase 'Picture'.

  const AnimeNode({
    required this.id,
    required this.title,
    required this.mainPicture,
  });

  // Método para crear una instancia de 'AnimeNode' desde un JSON.
  factory AnimeNode.fromJson(Map<String, dynamic> json) {
    return AnimeNode(
      id: json['id'],
      title: json['title'],
      mainPicture: Picture.fromJson(json['main_picture']),
    );
  }
}
