part of 'characters_cubit.dart';

enum CharactersStateStatus {
  initial,
  emptyLoading,
  success,
  loadingMore,
  failure
}

extension IsCharactersStateStatus on CharactersStateStatus {
  bool get isInitial => this == CharactersStateStatus.initial;
  bool get isEmptyLoading => this == CharactersStateStatus.emptyLoading;
  bool get isSuccess => this == CharactersStateStatus.success;
  bool get isLoadigMore => this == CharactersStateStatus.loadingMore;
  bool get isFailure => this == CharactersStateStatus.failure;
}

@JsonSerializable()
class CharactersState extends Equatable {
  final CharactersStateStatus status;
  final GetAllCharactersResponse? response;

  const CharactersState(
      {this.status = CharactersStateStatus.initial, this.response});

  factory CharactersState.fromJson(Map<String, dynamic> json) =>
      _$CharactersStateFromJson(json);

  CharactersState copyWith({
    CharactersStateStatus? status,
    GetAllCharactersResponse? response,
  }) =>
      CharactersState(
        status: status ?? this.status,
        response: response ?? this.response,
      );

  @override
  List<Object?> get props => [status, response];

  Map<String, dynamic> toJson() => _$CharactersStateToJson(this);
}
