import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

part 'characters_state.dart';
part 'characters_cubit.g.dart';

class CharactersCubit extends HydratedCubit<CharactersState> {
  CharactersCubit(this._repo) : super(const CharactersState());

  final RickAndMortyRepository _repo;

  Future<void> init() async {
    switch (state.status) {
      case CharactersStateStatus.initial:
      case CharactersStateStatus.emptyLoading:
      case CharactersStateStatus.failure:
        await getCharacters();
        break;
      case CharactersStateStatus.success:
      case CharactersStateStatus.loadingMore:
        break;
    }
  }

  Future<void> getCharacters({GetAllCharactersRequest? req}) async {
    emit(state.copyWith(status: CharactersStateStatus.emptyLoading));

    await _repo.getAllCharacters().then(
      (resp) async {
        final episodes = await _repo.getMultipleEpisodes(
            resp.characters.firstEpisodeId.toSet().toList());
        emit(state.copyWith(
          status: CharactersStateStatus.success,
          response: resp,
          firstEpisodes: episodes,
        ));
      },
    ).catchError(
      (_) {
        emit(state.copyWith(status: CharactersStateStatus.failure));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.status != CharactersStateStatus.success) return;
    if (!state.response!.hasNextPage) return;

    emit(state.copyWith(status: CharactersStateStatus.loadingMore));

    await _repo
        .getAllCharacters(
      req: GetAllCharactersRequest(page: state.response!.page + 1),
    )
        .then(
      (resp) async {
        final episodes = await _repo.getMultipleEpisodes(
          resp.characters.firstEpisodeId
            ..removeWhere(
              (episodeId) => state.firstEpisodes!.any((alreadyCachedEpisode) =>
                  alreadyCachedEpisode.id == episodeId),
            ),
        );
        emit(
          state.copyWith(
            status: CharactersStateStatus.success,
            response: resp.copyWith(
              characters: state.response!.characters..addAll(resp.characters),
            ),
            firstEpisodes: state.firstEpisodes!..addAll(episodes),
          ),
        );
      },
    ).catchError(
      (_) {
        emit(state.copyWith(status: CharactersStateStatus.failure));
      },
    );
  }

  @override
  CharactersState? fromJson(Map<String, dynamic> json) =>
      CharactersState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CharactersState state) =>
      state.status == CharactersStateStatus.success ? state.toJson() : null;
}
