import 'package:flutter/foundation.dart';

import '/models/anime_node.dart';
import '/models/picture.dart';

// Clase que representa los detalles completos de un anime.
class AnimeDetails {
  final int id;
  final String title;
  final Picture mainPicture;
  final AlternativeTitles alternativeTitles;
  final String startDate;
  final String endDate;
  final String synopsis;
  final dynamic mean; // Calificación promedio (puede ser int o double).
  final int rank;
  final int popularity;
  final int numListUsers;
  final int numScoringUsers;
  final String nsfw;
  final String createdAt;
  final String updatedAt;
  final String mediaType;
  final String status;
  final List<Genre> genres; // Lista de géneros asociados al anime.
  final int numEpisodes;
  final StartSeason startSeason; // Temporada en la que comenzó el anime.
  final Broadcast? broadcast; // Detalles de la transmisión (opcional).
  final String source;
  final int averageEpisodeDuration;
  final String rating;
  final List<Picture> pictures; // Lista de imágenes adicionales.
  final String background;
  final List<RelatedAnime> relatedAnime; // Lista de animes relacionados.
  final List<dynamic> relatedManga; // Lista de mangas relacionados.
  final List<Recommendation>
      recommendations; // Recomendaciones de animes similares.
  final List<Studio> studios; // Estudios involucrados en la producción.

  // Constructor que inicializa todas las propiedades.
  const AnimeDetails({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.alternativeTitles,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.mean,
    required this.rank,
    required this.popularity,
    required this.numListUsers,
    required this.numScoringUsers,
    required this.nsfw,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaType,
    required this.status,
    required this.genres,
    required this.numEpisodes,
    required this.startSeason,
    this.broadcast,
    required this.source,
    required this.averageEpisodeDuration,
    required this.rating,
    required this.pictures,
    required this.background,
    required this.relatedAnime,
    required this.recommendations,
    required this.studios,
    required this.relatedManga,
  });

  // Método que convierte un JSON en una instancia de AnimeDetails.
  factory AnimeDetails.fromJson(Map<String, dynamic> json) {
    return AnimeDetails(
      id: json['id'],
      title: json['title'],
      mainPicture: Picture.fromJson(json['main_picture']),
      alternativeTitles: AlternativeTitles.fromJson(json['alternative_titles']),
      startDate: json['start_date'] ?? 'Unknown',
      endDate: json['end_date'] ?? 'Unknown',
      synopsis: json['synopsis'],
      mean: json['mean'] ?? 0.0,
      rank: json['rank'] ?? 0,
      popularity: json['popularity'],
      numListUsers: json['num_list_users'],
      numScoringUsers: json['num_scoring_users'],
      nsfw: json['nsfw'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mediaType: json['media_type'],
      status: json['status'],
      genres: List<Genre>.from(
        json['genres'].map(
          (genre) => Genre.fromJson(genre),
        ),
      ),
      numEpisodes: json['num_episodes'],
      startSeason: json['start_season'] != null
          ? StartSeason.fromJson(json['start_season'])
          : const StartSeason(
              year: 2000,
              season: 'Unknown',
            ),
      broadcast: json['broadcast'] != null
          ? Broadcast.fromJson(json['broadcast'])
          : null,
      source: json['source'],
      averageEpisodeDuration: json['average_episode_duration'],
      rating: json['rating'],
      pictures: List<Picture>.from(
        json['pictures'].map(
          (picture) => Picture.fromJson(picture),
        ),
      ),
      background: json['background'],
      relatedAnime: List<RelatedAnime>.from(
        json['related_anime'].map(
          (anime) => RelatedAnime.fromJson(anime),
        ),
      ),
      relatedManga: json['related_manga'],
      recommendations: List<Recommendation>.from(
        json['recommendations'].map(
          (rec) => Recommendation.fromJson(rec),
        ),
      ),
      studios: List<Studio>.from(
        json['studios'].map(
          (studio) => Studio.fromJson(studio),
        ),
      ),
    );
  }
}

// Clases auxiliares para facilitar la conversión desde datos JSON.
@immutable
class AlternativeTitles {
  final List<String> synonyms; // Lista de sinónimos o variaciones del título.
  final String en; // Título en inglés.
  final String ja; // Título en japonés.

  const AlternativeTitles({
    required this.synonyms,
    required this.en,
    required this.ja,
  });

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) {
    return AlternativeTitles(
      synonyms: List<String>.from(json['synonyms']),
      en: json['en'],
      ja: json['ja'],
    );
  }
}

@immutable
class Genre {
  final int id; // Identificador único del género.
  final String name; // Nombre del género.

  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

@immutable
class StartSeason {
  final int year; // Año en el que se estrenó el anime.
  final String season; // Temporada (invierno, primavera, etc.).

  const StartSeason({
    required this.year,
    required this.season,
  });

  factory StartSeason.fromJson(Map<String, dynamic> json) {
    return StartSeason(
      year: json['year'],
      season: json['season'],
    );
  }
}

@immutable
class Broadcast {
  final String dayOfWeek; // Día de la semana en el que se transmite.
  final String startTime; // Hora de inicio de la transmisión.

  const Broadcast({
    required this.dayOfWeek,
    required this.startTime,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(
      dayOfWeek: json['day_of_the_week'],
      startTime: json['start_time'],
    );
  }
}

@immutable
class RelatedAnime {
  final AnimeNode node; // Nodo que representa el anime relacionado.
  final String relationType; // Tipo de relación (ej. precuela, secuela).
  final String
      relationTypeFormatted; // Descripción formateada del tipo de relación.

  const RelatedAnime({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedAnime.fromJson(Map<String, dynamic> json) {
    return RelatedAnime(
      node: AnimeNode.fromJson(json['node']),
      relationType: json['relation_type'],
      relationTypeFormatted: json['relation_type_formatted'],
    );
  }
}

@immutable
class RelatedManga {
  final AnimeNode node; // Nodo que representa el manga relacionado.
  final String relationType; // Tipo de relación (ej. precuela, secuela).
  final String
      relationTypeFormatted; // Descripción formateada del tipo de relación.

  const RelatedManga({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedManga.fromJson(Map<String, dynamic> json) {
    return RelatedManga(
      node: AnimeNode.fromJson(json['node']),
      relationType: json['relation_type'],
      relationTypeFormatted: json['relation_type_formatted'],
    );
  }
}

@immutable
class Recommendation {
  final AnimeNode node; // Nodo que representa el anime recomendado.
  final int numRecommendations; // Número de recomendaciones realizadas.

  const Recommendation({
    required this.node,
    required this.numRecommendations,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      node: AnimeNode.fromJson(json['node']),
      numRecommendations: json['num_recommendations'],
    );
  }
}

@immutable
class Studio {
  final int id; // Identificador único del estudio.
  final String name; // Nombre del estudio.

  const Studio({
    required this.id,
    required this.name,
  });

  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      id: json['id'],
      name: json['name'],
    );
  }
}
