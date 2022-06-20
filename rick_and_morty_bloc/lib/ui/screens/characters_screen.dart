import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc/cubit/characters/characters_cubit.dart';
import 'package:rick_and_morty_bloc/ui/screens/single_character_screen.dart';
import 'package:rick_and_morty_bloc/ui/widgets/black_overlay.dart';
import 'package:rick_and_morty_bloc/ui/widgets/character_card.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>(
      create: (context) =>
          CharactersCubit(context.read<RickAndMortyRepository>())..init(),
      child: const CharactersView(),
    );
  }
}

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() async {
        // Start loading more after reaching the last character card
        // maxScrollExtent-CharacterCard.height is used because the last widget
        // is the CircularProgressIndicator
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - CharacterCard.height) {
          context.read<CharactersCubit>().loadMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: context.read<CharactersCubit>().getCharacters,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const _CharactersAppBar(),
            BlocBuilder<CharactersCubit, CharactersState>(
                builder: (context, state) {
              switch (state.status) {
                case CharactersStateStatus.initial:
                  return const SliverToBoxAdapter(child: _GetAllButton());
                case CharactersStateStatus.emptyLoading:
                  return const SliverPadding(
                    padding: EdgeInsets.only(top: 40),
                    sliver: SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                case CharactersStateStatus.failure:
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 40),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: const [
                          Text('Something went wrong'),
                          _GetAllButton(),
                        ],
                      ),
                    ),
                  );
                case CharactersStateStatus.success:
                case CharactersStateStatus.loadingMore:
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverFixedExtentList(
                      itemExtent: CharacterCard.height + 10,
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          if (i >= state.response!.characters.length) {
                            if (state.response!.hasNextPage) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return const Center(child: Text('All loaded'));
                          }
                          Character char = state.response!.characters[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CharacterCard(
                              character: char,
                              firstEpisodeName: state.firstEpisodes!
                                  .firstWhere(
                                      (e) => e.id == char.firstEpisodeId)
                                  .name,
                              onTap: () {
                                Navigator.of(context)
                                    .push(SingleCharacterPage.route(char.id));
                              },
                            ),
                          );
                        },
                        childCount: state.response!.characters.length + 1,
                      ),
                    ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _CharactersAppBar extends StatelessWidget {
  const _CharactersAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Characters'),
        background: BlackOverlay(
          child: Image.asset(
            'assets/characters.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
    );
  }
}

class _GetAllButton extends StatelessWidget {
  const _GetAllButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<CharactersCubit>().getCharacters(),
      child: const Text('Tap to get characters'),
    );
  }
}
