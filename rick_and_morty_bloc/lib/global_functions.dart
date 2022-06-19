import 'package:flutter/material.dart' show Color;
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

extension CharacterStatusX on CharacterStatus {
  Color get color {
    switch (this) {
      case CharacterStatus.alive:
        return const Color.fromARGB(255, 85, 204, 68);
      case CharacterStatus.dead:
        return const Color.fromARGB(255, 214, 61, 46);
      case CharacterStatus.unknown:
        return const Color.fromARGB(255, 158, 158, 158);
    }
  }
}

extension StringX on String {
  String toCapitalize() => this[0].toUpperCase() + substring(1).toLowerCase();
}
