import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

part 'single_character_state.dart';

typedef _Status = SingleCharacterStateStatus;
typedef _State = SingleCharacterState;

class SingleCharacterCubit extends Cubit<_State> {
  SingleCharacterCubit({
    required int characterId,
    required RickAndMortyRepository repo,
  })  : _repo = repo,
        super(const _State(status: _Status.loadingChar)) {
    fetchCharacter(characterId);
  }

  final RickAndMortyRepository _repo;

  Future<void> fetchCharacter(int characterId) async {
    emit(state.copyWith(status: _Status.loadingChar));

    await _repo.getSingleCharacter(characterId).then(
      (character) {
        emit(
          state.copyWith(
            status: _Status.successChar,
            character: character,
          ),
        );
        fetchRelatedEpisodes(character.episodesId);
      },
    ).catchError(
      (_) {
        emit(state.copyWith(status: _Status.failureChar));
      },
    );
  }

  Future fetchRelatedEpisodes(List<int> episodesId) async {
    emit(state.copyWith(status: _Status.loadingEpisodes));

    await _repo
        .getMultipleEpisodes(episodesId)
        .then(
          (episodes) => emit(state.copyWith(
            episodes: episodes,
            status: _Status.successEpisodes,
          )),
        )
        .catchError(
          (_) => emit(state.copyWith(status: _Status.failureEpisodes)),
        );
  }
}
