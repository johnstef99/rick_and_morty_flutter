// Exporting the exact same models from API since we don't need anything
// different, but still exporting them so the app will not use models directly
// from the API
export 'package:rick_and_morty_api/rick_and_morty_api.dart'
    show
        Character,
        CharacterLocation,
        CharacterGender,
        CharacterStatus,
        Episode;

import 'package:rick_and_morty_api/rick_and_morty_api.dart' show Character;

extension CharacterX on Character {
  /// Get ids from episodes urls
  List<int> get episodesId => episode.map((e) => parseEpisodeUrl(e)).toList()
    ..removeWhere((e) => e == -1);

  int get firstEpisodeId => parseEpisodeUrl(episode.first);
}

extension ListCharacterX on List<Character> {
  /// Get ids from episodes urls
  List<int> get firstEpisodeId =>
      map((char) => parseEpisodeUrl(char.episode.first)).toList()
        ..removeWhere((e) => e == -1);
}

/// return -1 if episodeUrl couldn't be parsed
int parseEpisodeUrl(String episodeUrl) =>
    int.tryParse(episodeUrl.split('/').last) ?? -1;
