// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersState _$CharactersStateFromJson(Map<String, dynamic> json) =>
    CharactersState(
      status:
          $enumDecodeNullable(_$CharactersStateStatusEnumMap, json['status']) ??
              CharactersStateStatus.initial,
      response: json['response'] == null
          ? null
          : GetAllCharactersResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      firstEpisodes: (json['firstEpisodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharactersStateToJson(CharactersState instance) =>
    <String, dynamic>{
      'status': _$CharactersStateStatusEnumMap[instance.status],
      'response': instance.response,
      'firstEpisodes': instance.firstEpisodes,
    };

const _$CharactersStateStatusEnumMap = {
  CharactersStateStatus.initial: 'initial',
  CharactersStateStatus.emptyLoading: 'emptyLoading',
  CharactersStateStatus.success: 'success',
  CharactersStateStatus.loadingMore: 'loadingMore',
  CharactersStateStatus.failure: 'failure',
};
