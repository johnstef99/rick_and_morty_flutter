part of 'single_character_cubit.dart';

enum SingleCharacterStateStatus { loading, success, failure }

extension SingleCharacterStateStatusX on SingleCharacterStateStatus {
  bool get isLoading => this == SingleCharacterStateStatus.loading;
  bool get isSuccess => this == SingleCharacterStateStatus.success;
  bool get isFailure => this == SingleCharacterStateStatus.failure;
}

class SingleCharacterState extends Equatable {
  final SingleCharacterStateStatus status;
  final Character? character;

  const SingleCharacterState({
    required this.status,
    this.character,
  });

  SingleCharacterState copyWith({
    SingleCharacterStateStatus? status,
    Character? character,
  }) =>
      SingleCharacterState(
        status: status ?? this.status,
        character: character ?? this.character,
      );

  @override
  List<Object?> get props => [status, character];
}
