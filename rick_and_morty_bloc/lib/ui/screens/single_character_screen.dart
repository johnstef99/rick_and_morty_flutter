import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc/cubit/single_character/single_character_cubit.dart';
import 'package:rick_and_morty_bloc/global_functions.dart';
import 'package:rick_and_morty_bloc/rick_and_motry_icons.dart';
import 'package:rick_and_morty_bloc/ui/widgets/black_overlay.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class SingleCharacterPage extends StatelessWidget {
  const SingleCharacterPage({Key? key}) : super(key: key);

  static Route route(int characterId) => MaterialPageRoute<void>(
        builder: (_) => BlocProvider<SingleCharacterCubit>(
          create: (BuildContext context) => SingleCharacterCubit(
            characterId: characterId,
            repo: context.read<RickAndMortyRepository>(),
          ),
          child: const SingleCharacterPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return const SingleCharacterView();
  }
}

class SingleCharacterView extends StatelessWidget {
  const SingleCharacterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          _AppBar(),
          _InfoSection(),
          _EpisodesSection(),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCharacterCubit, SingleCharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case SingleCharacterStateStatus.loadingChar:
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          case SingleCharacterStateStatus.failureChar:
            return SliverFillRemaining(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Something went wrong'),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<SingleCharacterCubit>().fetchCharacter(),
                    child: const Text('Tap to try load character againg'),
                  ),
                ],
              ),
            );
          case SingleCharacterStateStatus.successEpisodes:
          case SingleCharacterStateStatus.failureEpisodes:
          case SingleCharacterStateStatus.loadingEpisodes:
          case SingleCharacterStateStatus.successChar:
            final character = state.character!;
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              sliver: SliverGrid.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _InfoRow(
                    iconData: RickAndMotry.dna,
                    text: character.species,
                  ),
                  _InfoRow(
                    iconData: RickAndMotry.transgender,
                    text: character.gender.name,
                  ),
                  _InfoRow(
                    iconData: RickAndMotry.location,
                    text: character.location.name,
                  ),
                  if (character.type.isNotEmpty)
                    _InfoRow(
                      iconData: RickAndMotry.muscle_up,
                      text: character.type,
                    ),
                ],
              ),
            );
        }
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({Key? key, required this.text, required this.iconData})
      : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text.toCapitalize(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(iconData, size: 32),
              Text(
                text.toCapitalize(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final h = md.size.height;
    return BlocBuilder<SingleCharacterCubit, SingleCharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case SingleCharacterStateStatus.failureChar:
            return SliverAppBar(
              stretch: true,
              expandedHeight: h * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Error Happend'),
                background: BlackOverlay(
                  child: Image.asset(
                    'assets/characters.jpg',
                    fit: BoxFit.cover,
                  ), //TODO: find appropriate image
                ),
              ),
            );
          case SingleCharacterStateStatus.loadingEpisodes:
          case SingleCharacterStateStatus.failureEpisodes:
          case SingleCharacterStateStatus.successEpisodes:
          case SingleCharacterStateStatus.loadingChar:
          case SingleCharacterStateStatus.successChar:
            return SliverAppBar(
              stretch: true,
              expandedHeight: h * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                title: state.status.isLoadingChar
                    ? null
                    : Text(state.character!.name),
                background: state.status.isLoadingChar
                    ? null
                    : BlackOverlay(
                        child: CachedNetworkImage(
                          imageUrl: state.character!.image,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            );
        }
      },
    );
  }
}

class _EpisodesSection extends StatelessWidget {
  const _EpisodesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCharacterCubit, SingleCharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case SingleCharacterStateStatus.failureChar:
          case SingleCharacterStateStatus.loadingChar:
            return const SliverToBoxAdapter();
          case SingleCharacterStateStatus.successChar:
          case SingleCharacterStateStatus.loadingEpisodes:
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          case SingleCharacterStateStatus.failureEpisodes:
            return const SliverToBoxAdapter(
              child: Text('Could not load episodes'),
            );
          case SingleCharacterStateStatus.successEpisodes:
            final List<String> seasons = state.episodes!
                .map((e) => e.episode.substring(1, 3))
                .toSet()
                .toList();
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    for (String season in seasons) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Season $season',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          for (int? episode in state.episodes!
                              .where((e) => e.episode.substring(1, 3) == season)
                              .map((e) =>
                                  int.tryParse(e.episode.substring(4, 6)))
                              .toList())
                            if (episode != null)
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Card(
                                  child:
                                      Center(child: Text(episode.toString())),
                                  shape: const CircleBorder(),
                                ),
                              )
                        ],
                      )
                    ]
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
