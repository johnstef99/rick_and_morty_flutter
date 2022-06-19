import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';
part 'character_enums.dart';
part 'character_location.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
