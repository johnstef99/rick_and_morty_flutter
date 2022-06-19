import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

part 'get_all_characters_response.g.dart';

@JsonSerializable()
class GetAllCharactersResponse extends Equatable {
  final List<Character> characters;
  final int page;
  final int numOfPages;

  bool get hasNextPage => page < numOfPages;
  bool get hasPrevPage => page > 1;

  const GetAllCharactersResponse({
    required this.characters,
    required this.page,
    required this.numOfPages,
  });

  GetAllCharactersResponse copyWith({
    List<Character>? characters,
    int? page,
    int? numOfPages,
  }) {
    return GetAllCharactersResponse(
      characters: characters ?? this.characters,
      page: page ?? this.page,
      numOfPages: numOfPages ?? this.numOfPages,
    );
  }

  factory GetAllCharactersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCharactersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCharactersResponseToJson(this);

  @override
  List<Object?> get props => [characters, page, numOfPages];
}
