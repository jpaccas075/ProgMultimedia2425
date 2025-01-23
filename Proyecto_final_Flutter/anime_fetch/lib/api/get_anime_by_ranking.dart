import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/config/app_config.dart';
import '/models/anime.dart';

/* Función que obtiene una lista de animes según el tipo de ranking especificado.
Parámetros:
- rankingType: Tipo de ranking (por ejemplo, "top", "airing", "favorite").
- limit: Número máximo de resultados a obtener. */

Future<Iterable<Anime>> getAnimeByRankingTypeApi({
  required String rankingType,
  required int limit,
}) async {
  // Construye la URL de la API con los parámetros recibidos.
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';

  // Realiza la solicitud HTTP GET a la API.
  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID':
          apiKey, // Añade el identificador del usuario en los encabezados.
    },
  );

  // Verifica si la respuesta fue exitosa.
  if (response.statusCode == 200) {
    // Decodifica la respuesta JSON.
    final Map<String, dynamic> data = jsonDecode(response.body);

    // Extrae la lista de animes desde la clave 'data'.
    final List<dynamic> animeNodeList = data['data'];

    // Filtra la lista para eliminar animes sin imagen principal, ya que podrían romper la vista de la lista.
    final animes = animeNodeList
        .where(
      (animeNode) => animeNode['node']['main_picture'] != null,
    )
        .map(
      // Mapea cada nodo a un objeto de tipo Anime usando su constructor fromJson.
      (node) {
        return Anime.fromJson(node);
      },
    );

    return animes;
  } else {
    // Si la respuesta no es exitosa, imprime los errores en la consola.
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");

    // Lanza una excepción indicando que la obtención de datos falló.
    throw Exception("Failed to get data!");
  }
}
