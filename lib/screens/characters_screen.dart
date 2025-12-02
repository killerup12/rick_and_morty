import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty/features/characters/characters.dart';
import 'package:rick_and_morty/shared/list_controls/list_controls.dart';
import 'package:rick_and_morty/shared/route_storage/route_storage.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> with DependencyPermission {
  late final charactersStore = getStore<CharactersStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginationBuilder(
        onRefresh: charactersStore.refresh,
        onPaginate: charactersStore.upload,
        uploadCondition: () => charactersStore.canUploadMore,
        builder: (context, controller) {
          return Observer(
            builder: (context) {
              final chars = charactersStore.characters;

              if (chars == null) return const Center(child: CircularProgressIndicator());
              return CupertinoScrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16) + MediaQuery.paddingOf(context).copyWith(bottom: 0),
                  controller: controller,
                  itemCount: chars.length + (charactersStore.canUploadMore ? 0 : 1),
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index >= chars.length && charactersStore.canUploadMore) {
                      return const Center(
                        child: Padding(padding: .all(16), child: CircularProgressIndicator()),
                      );
                    }
                    return CharacterCard(chars[index], onFavorite: () {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
