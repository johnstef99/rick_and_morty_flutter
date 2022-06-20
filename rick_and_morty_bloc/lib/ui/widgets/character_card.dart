import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_bloc/global_functions.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.character,
    required this.firstEpisodeName,
    this.onTap,
  }) : super(key: key);

  final Character character;
  final String firstEpisodeName;
  final GestureTapCallback? onTap;

  static const double _borderRadius = 10;
  static const double height = 150;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
          onTap: onTap,
          child: Row(
            children: [
              _Image(borderRadius: _borderRadius, imageUrl: character.image),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Name(character: character),
                      _Info(
                        description: 'Last known location:',
                        info: character.location.name,
                      ),
                      _Info(
                        description: 'First seen in:',
                        info: firstEpisodeName,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  final TextStyle nameTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  final statusTextStyle = const TextStyle(
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: nameTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: character.status.color,
              ),
              width: 10,
              height: 10,
            ),
            const SizedBox(width: 5),
            Text(
              '${character.status.name.toCapitalize()} - ${character.species.toCapitalize()}',
              style: statusTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    Key? key,
    required this.info,
    required this.description,
  }) : super(key: key);

  final String description;
  final String info;

  final descTextStyle = const TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  final infoTextStyle = const TextStyle(
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: descTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          info.toCapitalize(),
          style: infoTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key, required this.borderRadius, required this.imageUrl})
      : super(key: key);

  final double borderRadius;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ),
    );
  }
}
