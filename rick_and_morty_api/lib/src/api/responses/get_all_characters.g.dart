// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_characters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCharactersResponse _$GetAllCharactersResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCharactersResponse(
      Info.fromJson(json['info'] as Map<String, dynamic>),
      (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCharactersResponseToJson(
        GetAllCharactersResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.characters,
    };
