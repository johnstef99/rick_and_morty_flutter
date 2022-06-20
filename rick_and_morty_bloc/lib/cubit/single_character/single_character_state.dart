part of 'single_character_cubit.dart';

enum SingleCharacterStateStatus {
  loadingChar,
  successChar,
  failureChar,
  loadingEpisodes,
  successEpisodes,
  failureEpisodes,
}

extension SingleCharacterStateStatusX on SingleCharacterStateStatus {
  bool get isLoadingChar => this == SingleCharacterStateStatus.loadingChar;
  bool get isSuccessChar => this == SingleCharacterStateStatus.successChar;
  bool get isFailureChar => this == SingleCharacterStateStatus.failureChar;
  bool get isLoadingEpisodes =>
      this == SingleCharacterStateStatus.loadingEpisodes;
  bool get isSuccessEpisodes =>
      this == SingleCharacterStateStatus.successEpisodes;
  bool get isFailureEpisodes =>
      this == SingleCharacterStateStatus.failureEpisodes;
}

class SingleCharacterState extends Equatable {
  final SingleCharacterStateStatus status;
  final Character? character;
  final List<Episode>? episodes;

  const SingleCharacterState({
    required this.status,
    this.character,
    this.episodes,
  });

  SingleCharacterState copyWith({
    SingleCharacterStateStatus? status,
    Character? character,
    List<Episode>? episodes,
  }) =>
      SingleCharacterState(
        status: status ?? this.status,
        character: character ?? this.character,
        episodes: episodes ?? this.episodes,
      );

  @override
  List<Object?> get props => [status, character, episodes];
}
