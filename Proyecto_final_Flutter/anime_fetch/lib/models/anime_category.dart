import 'package:flutter/material.dart';

@immutable
class AnimeCategory {
  final String title;
  final String rankingType;

  const AnimeCategory({
    required this.title, // Título de la categoría (ej. "Top Anime").
    required this.rankingType, // Tipo de clasificación (ej. "all", "airing").
  });

  // Fábrica para crear instancias de AnimeCategory a partir de un JSON.
  factory AnimeCategory.fromJson(Map<String, dynamic> json) {
    return AnimeCategory(
      title: json['title'],
      rankingType: json['rankingType'],
    );
  }
}

// Lista que define varias categorías de anime predefinidas.
// Cada categoría tiene un título y un tipo de clasificación.
const animeCategories = [
  AnimeCategory(title: 'Top Anime', rankingType: 'all'),
  AnimeCategory(title: 'Top Airing', rankingType: 'airing'),
  AnimeCategory(title: 'Top Upcoming', rankingType: 'upcoming'),
  AnimeCategory(title: 'Top TV Series', rankingType: 'tv'),
  AnimeCategory(title: 'Top OVA', rankingType: 'ova'),
  AnimeCategory(title: 'Top Movies', rankingType: 'movie'),
  AnimeCategory(title: 'Top Specials', rankingType: 'special'),
  AnimeCategory(title: 'Top Popular', rankingType: 'bypopularity'),
  AnimeCategory(title: 'Top Favorited', rankingType: 'favorite'),
];
