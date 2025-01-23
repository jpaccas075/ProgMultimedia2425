import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/config/app_config.dart';
import '/models/anime_details.dart';

/* Función que obtiene los detalles de un anime específico desde la API.
Parámetro:
- id: Identificador del anime.
Devuelve:
- Un objeto AnimeDetails con la información detallada del anime. */

Future<AnimeDetails> getAnimeDetailsApi({
  required int id,
}) async {
  // Construye la URL de la API, incluyendo el ID del anime y los campos detallados a recuperar.
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';

  // Realiza la solicitud HTTP.
  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': apiKey,
    },
  );

  if (response.statusCode == 200) {
    // Respuesta exitosa: decodifica la respuesta JSON en un mapa de datos.
    final Map<String, dynamic> data = jsonDecode(response.body);

    // Crea un objeto AnimeDetails a partir de los datos obtenidos.
    final animeDetails = AnimeDetails.fromJson(data);

    return animeDetails; // Devuelve los detalles del anime.
  } else {
    debugPrint('Code: ${response.statusCode}');
    debugPrint('Error: ${response.body}');
    throw Exception('Failed to get data!');
  }
}
