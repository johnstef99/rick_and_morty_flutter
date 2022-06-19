// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: $enumDecode(_$CharacterStatusEnumMap, json['status']),
      species: json['species'] as String,
      type: json['type'] as String,
      gender: $enumDecode(_$CharacterGenderEnumMap, json['gender']),
      origin:
          CharacterLocation.fromJson(json['origin'] as Map<String, dynamic>),
      location:
          CharacterLocation.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$CharacterStatusEnumMap[instance.status],
      'species': instance.species,
      'type': instance.type,
      'gender': _$CharacterGenderEnumMap[instance.gender],
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
    };

const _$CharacterStatusEnumMap = {
  CharacterStatus.alive: 'Alive',
  CharacterStatus.dead: 'Dead',
  CharacterStatus.unknown: 'unknown',
};

const _$CharacterGenderEnumMap = {
  CharacterGender.female: 'Female',
  CharacterGender.male: 'Male',
  CharacterGender.genderless: 'Genderless',
  CharacterGender.unknown: 'unknown',
};

CharacterLocation _$CharacterLocationFromJson(Map<String, dynamic> json) =>
    CharacterLocation(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CharacterLocationToJson(CharacterLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
