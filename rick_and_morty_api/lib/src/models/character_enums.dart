part of 'character.dart';

enum CharacterStatus {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('unknown')
  unknown,
}

enum CharacterGender {
  @JsonValue('Female')
  female,
  @JsonValue('Male')
  male,
  @JsonValue('Genderless')
  genderless,
  @JsonValue('unknown')
  unknown,
}
