// Exporting the exact same models from API since we don't need anything
// different, but still exporting them so the app will not use models directly
// from the API
export 'package:rick_and_morty_api/rick_and_morty_api.dart'
    show Character, CharacterLocation, CharacterGender, CharacterStatus;
