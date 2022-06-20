import 'package:json_annotation/json_annotation.dart';

part 'get_all_characters.g.dart';

@JsonSerializable()
class GetAllCharactersRequest {
  final int? page;
  //TODO: add filter options

  const GetAllCharactersRequest({this.page});

  factory GetAllCharactersRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAllCharactersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCharactersRequestToJson(this);

  Map<String, String> toQuery() =>
      (toJson()..removeWhere((key, value) => value == null)).map(
        (key, value) => MapEntry(
          key,
          value.toString(),
        ),
      );
}
