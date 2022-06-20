import 'dart:async';

import 'package:rick_and_morty_api/rick_and_morty_api.dart'
    show RickAndMortyApiClient;
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class RickAndMortyRepository {
  RickAndMortyRepository({RickAndMortyApiClient? apiCliend})
      : _apiClient = apiCliend ?? RickAndMortyApiClient();

  final RickAndMortyApiClient _apiClient;

  Future<GetAllCharactersResponse> getAllCharacters(
      {GetAllCharactersRequest? req}) async {
    final res = await _apiClient.getAllCharacters(req);
    return GetAllCharactersResponse(
      characters: res.characters,
      page: req?.page ?? 1,
      numOfPages: res.info.pages,
    );
  }

  Future<Character> getSingleCharacter(int characterId) async {
    final res = await _apiClient.getSingleCharacter(characterId);
    return res;
  }

  Future<List<Episode>> getMultipleEpisodes(List<int> episodesId) async {
    final res = await _apiClient.getMultipleEpisodes(episodesId);
    return res;
  }
}
