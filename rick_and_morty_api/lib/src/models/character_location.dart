part of 'character.dart';

@JsonSerializable()
class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);

  String name;
  String url;

  int? get id => int.tryParse(url.split('/').last);

  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);
}
