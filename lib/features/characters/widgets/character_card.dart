part of '../characters.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {this.isFavorite = false, this.onFavorite, this.onPressed, super.key});

  final Character character;
  final bool isFavorite;
  final VoidCallback? onFavorite;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Semantics(
          label: 'Character ${character.name}',
          child: Column(
            spacing: 8,
            mainAxisSize: .min,
            children: [
              if (onFavorite != null)
                Semantics(
                  button: true,
                  label: 'Add ${character.name} to favorites',
                  child: IconButton(icon: Icon(isFavorite ? Icons.star : Icons.star_border), onPressed: onFavorite),
                ),
              Row(
                spacing: 16,
                crossAxisAlignment: .start,
                children: [
                  CachedNetworkImage(
                    imageUrl: character.imageUri.toString(),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => SizedBox.square(dimension: 100, child: Center(child: Icon(Icons.image))),
                  ),
                  Flexible(
                    child: Padding(
                      padding: .only(top: 8, bottom: 8, right: 8),
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .start,
                        children: [
                          Text(character.name, maxLines: 1, overflow: .ellipsis),
                          Text(character.gender, maxLines: 1, overflow: .ellipsis),
                          Text(character.status, maxLines: 1, overflow: .ellipsis),
                          Text(character.species, maxLines: 1, overflow: .ellipsis),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
