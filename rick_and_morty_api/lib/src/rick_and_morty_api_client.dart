import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

/// Exception thrown when getAllCharacters fails.
class CharactersRequestFailure implements Exception {}

/// Exception thrown when getSingleCharacter fails.
class SingleCharacterRequestFailure implements Exception {}

/// Exception thrown when character with the provided id is not found
class CharacterNotFoundFailure implements Exception {}

/// Exception thrown when character with the provided id is not found
class MultipleEpisodesNotFoundFailure implements Exception {}

/// {@template rick_and_morty_api_client}
/// Dart API Client which wraps the [Rick and Morty API](https://rickandmortyapi.com/).
/// {@endtemplate}
class RickAndMortyApiClient {
  /// {@macro rick_and_morty_api_client}
  RickAndMortyApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'rickandmortyapi.com';
  final http.Client _httpClient;

  /// Gets all [Character] `/character`.
  Future<GetAllCharactersResponse> getAllCharacters(
    GetAllCharactersRequest? request,
  ) async {
    final req = Uri.https(
      _baseUrl,
      '/api/character',
      request?.toQuery(),
    );
    final res = await _httpClient.get(req);

    if (res.statusCode != 200) {
      throw CharactersRequestFailure();
    }

    final body = jsonDecode(
      res.body,
    ) as Map<String, dynamic>;

    return GetAllCharactersResponse.fromJson(body);
  }

  /// Gets single [Character] `/character/{id}`.
  Future<Character> getSingleCharacter(
    int characterId,
  ) async {
    final req = Uri.https(
      _baseUrl,
      '/api/character/$characterId',
    );
    final res = await _httpClient.get(req);

    if (res.statusCode != 200) {
      throw SingleCharacterRequestFailure();
    }

    final body = jsonDecode(
      res.body,
    ) as Map<String, dynamic>;

    return Character.fromJson(body);
  }

  Future<List<Episode>> getMultipleEpisodes(List<int> episodesId) async {
    final req = Uri.https(
      _baseUrl,
      '/api/episode/${episodesId.join(',')}',
    );
    final res = await _httpClient.get(req);

    if (res.statusCode != 200) {
      throw MultipleEpisodesNotFoundFailure();
    }

    final body = jsonDecode(
      res.body,
    ) as List<Map<String, dynamic>>;

    return body.map((e) => Episode.fromJson(e)).toList();
  }
}
