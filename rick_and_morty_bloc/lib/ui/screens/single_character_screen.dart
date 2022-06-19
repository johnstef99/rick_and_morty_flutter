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
          case SingleCharacterStateStatus.loading:
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          case SingleCharacterStateStatus.failure:
            return SliverFillRemaining(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Something went wrong'),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Tap here to load character againg'),
                  ),
                ],
              ),
            );
          case SingleCharacterStateStatus.success:
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
          case SingleCharacterStateStatus.failure:
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
          case SingleCharacterStateStatus.loading:
          case SingleCharacterStateStatus.success:
            return SliverAppBar(
              stretch: true,
              expandedHeight: h * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                title:
                    state.status.isLoading ? null : Text(state.character!.name),
                background: state.status.isLoading
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
