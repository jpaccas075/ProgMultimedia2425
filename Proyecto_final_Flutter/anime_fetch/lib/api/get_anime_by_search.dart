import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/config/app_config.dart';
import '/models/anime.dart';
import '/models/anime_info.dart';

/* Función que busca animes en la API según la consulta proporcionada.
Parámetro:
- query: Texto de búsqueda introducido por el usuario.
Devuelve:
- Una lista de objetos Anime. */

Future<Iterable<Anime>> getAnimesbySearchApi({
  required String query,
}) async {
  // Construye la URL de la API con la consulta de búsqueda y un límite de 10 resultados.
  final baseUrl = "https://api.myanimelist.net/v2/anime?q=$query&limit=10";

  // Realiza la solicitud HTTP.
  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': apiKey,
    },
  );

  if (response.statusCode == 200) {
    // Respuesta exitosa: decodifica la respuesta JSON en un mapa de datos.
    final Map<String, dynamic> data = json.decode(response.body);

    // Crea un objeto AnimeInfo a partir de los datos decodificados.
    AnimeInfo animeInfo = AnimeInfo.fromJson(data);

    // Obtiene la lista de animes desde el objeto AnimeInfo.
    Iterable<Anime> animes = animeInfo.animes;

    return animes;
  } else {
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");
    throw Exception("Failed to get data!");
  }
}
