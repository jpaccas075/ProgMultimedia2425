import 'package:flutter/foundation.dart';

import '/models/anime_info.dart';
import '/models/anime_node.dart';

// Modela un anime con dos elementos principales (node y ranking).
@immutable
class Anime {
  final AnimeNode node; // Representa la información básica del anime.
  final Ranking? ranking; // Representa la posición del anime en el ranking (opcional).

  const Anime({
    required this.node,
    this.ranking,
  });

  // Método para crear una instancia de 'Anime' desde un JSON.
  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      node: AnimeNode.fromJson(json['node']),
      ranking:
          json['ranking'] != null ? Ranking.fromJson(json['ranking']) : null,
    );
  }
}
