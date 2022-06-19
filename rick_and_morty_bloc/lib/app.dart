import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc/ui/screens/characters_screen.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp(
      {Key? key, required RickAndMortyRepository rickAndMortyRepository})
      : _rickAndMortyRepository = rickAndMortyRepository,
        super(key: key);

  final RickAndMortyRepository _rickAndMortyRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _rickAndMortyRepository, child: const RickAndMortyAppView());
  }
}

class RickAndMortyAppView extends StatelessWidget {
  const RickAndMortyAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        iconTheme: const IconThemeData(color: Color(0xff97ce4c)),
        brightness: Brightness.dark,
      ),
      home: const CharactersPage(),
    );
  }
}
