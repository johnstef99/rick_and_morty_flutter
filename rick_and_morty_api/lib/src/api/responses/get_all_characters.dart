import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:rick_and_morty_api/src/api/info.dart';

part 'get_all_characters.g.dart';

@JsonSerializable()
class GetAllCharactersResponse {
  final Info info;
  @JsonKey(name: 'results')
  final List<Character> characters;

  const GetAllCharactersResponse(this.info, this.characters);

  factory GetAllCharactersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCharactersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCharactersResponseToJson(this);
}
