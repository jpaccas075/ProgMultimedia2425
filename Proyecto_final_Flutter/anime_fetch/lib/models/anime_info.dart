import 'package:flutter/foundation.dart';

import '/models/anime.dart';

@immutable
class AnimeInfo {
  final Iterable<Anime> animes; // Lista iterable de objetos 'Anime'.

  const AnimeInfo({
    required this.animes,
  });

  // Método para crear una instancia de 'AnimeInfo' desde un JSON.
  factory AnimeInfo.fromJson(Map<String, dynamic> json) {
    // Extrae la lista de animes del campo 'data' en el JSON.
    List<dynamic> animeRankingList = json['data'];

    // Mapea cada elemento de la lista a un objeto de tipo 'Anime'.
    List<Anime> animeRankingItems = animeRankingList
        .map(
          (item) => Anime.fromJson(item),
        )
        .toList();

    return AnimeInfo(
      animes: animeRankingItems,
    );
  }
}

@immutable
class Ranking {
  final int rank; // Representa la posición de un anime en el ranking.

  const Ranking({
    required this.rank,
  });

  // Método para crear una instancia de 'Ranking' desde un JSON.
  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      rank: json['rank'],
    );
  }
}
