// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_characters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCharactersResponse _$GetAllCharactersResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCharactersResponse(
      characters: (json['characters'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int,
      numOfPages: json['numOfPages'] as int,
    );

Map<String, dynamic> _$GetAllCharactersResponseToJson(
        GetAllCharactersResponse instance) =>
    <String, dynamic>{
      'characters': instance.characters,
      'page': instance.page,
      'numOfPages': instance.numOfPages,
    };
