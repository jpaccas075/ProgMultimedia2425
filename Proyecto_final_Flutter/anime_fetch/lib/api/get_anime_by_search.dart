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
  try {
    // Construye la URL de la API con los parámetros recibidos.
    final baseUrl = "https://api.myanimelist.net/v2/anime?q=$query&limit=10";

    // Realiza la solicitud HTTP GET a la API.
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'X-MAL-CLIENT-ID': apiKey},
    );

    // Verifica si la respuesta fue exitosa.
    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON.
      final Map<String, dynamic> data = json.decode(response.body);

      // Convierte los datos en un objeto de tipo AnimeInfo.
      AnimeInfo animeInfo = AnimeInfo.fromJson(data);

      // Devuelve la lista de animes obtenida.
      return animeInfo.animes;
    } else {
      debugPrint("Error: ${response.statusCode} - ${response.body}");
      // Devuelve una lista vacía para evitar que la aplicación se bloquee.
      return [];
    }
  } catch (e) {
    debugPrint("Exception: $e");
    // Devuelve una lista vacía en caso de excepción para mantener la estabilidad de la app.
    return [];
  }
}
