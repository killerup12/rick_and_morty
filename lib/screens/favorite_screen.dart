import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty/features/characters/characters.dart';
import 'package:rick_and_morty/shared/route_storage/route_storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with DependencyPermission {
  late final charactersStore = getStore<CharactersStore>();
  late final favoritesStore = getStore<FavoritesStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          final characters = favoritesStore.favorites;

          if (characters == null) return const Center(child: CircularProgressIndicator());
          return CupertinoScrollbar(
            child: ListView.separated(
              padding: const EdgeInsets.all(16) + MediaQuery.paddingOf(context).copyWith(bottom: 0),
              itemCount: characters.length + (charactersStore.canUploadMore ? 0 : 1),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (index >= characters.length && charactersStore.canUploadMore) {
                  return const Center(
                    child: Padding(padding: .all(16), child: CircularProgressIndicator()),
                  );
                }

                final character = characters[index];
                return CharacterCard(
                  character,
                  isFavorite: favoritesStore.isFavorite(character),
                  onFavorite: () => favoritesStore.toggle(character),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
