part of '../characters.dart';

class FavoritesStore = _FavoritesStoreBase with _$FavoritesStore;

abstract class _FavoritesStoreBase with RouteInjectable, Store {
  _FavoritesStoreBase({required CharactersFavoritesServices services}) : _services = services;

  final CharactersFavoritesServices _services;

  @readonly
  ObservableList<Character>? _favorites;

  bool isFavorite(Character character) => _favorites?.contains(character) ?? false;

  @override
  void init() async {
    super.init();
    final result = await _services.getFavorites();
    _favorites = result.response.asObservable();
  }

  @override
  void dispose() {
    super.dispose();
    _favorites = null;
  }

  @action
  Future<void> toggle(Character character) async {
    if (isFavorite(character)) {
      await _services.removeFavorite(character);
      _favorites?.remove(character);
    } else {
      await _services.addFavorite(character);
      _favorites?.add(character);
    }
  }
}
