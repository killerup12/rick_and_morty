part of '../characters.dart';

class CharactersStore = _CharactersStoreBase with _$CharactersStore;

abstract class _CharactersStoreBase with Store, RouteInjectable, ListControlsMixin<CharactersFilters> {
  _CharactersStoreBase({required CharactersServices onlineServices, required CharactersServicesWritable localServices})
    : _onlineServices = onlineServices,
      _localServices = localServices;

  final CharactersServices _onlineServices;
  final CharactersServicesWritable _localServices;

  @override
  final filters = CharactersFilters();

  @readonly
  ObservableList<Character>? _characters;
  @readonly
  ObservableList<Character>? _favorites;

  bool isFavorite(Character character) => _favorites?.contains(character) ?? false;

  @override
  void init() {
    super.init();
    _localServices.getFavorites().then((result) {
      _favorites = result.response.asObservable();
    });
    uploadRequest((filters) => _onlineServices.getCharacters(filters))
        .then((result) {
          _localServices.save(result);
          return result;
        })
        .onError((_, __) {
          return _localServices.getCharacters(filters).then((result) => result.response);
        })
        .then((result) {
          return _characters = result.asObservable();
        });
  }

  @override
  void dispose() {
    _characters = null;
    _favorites = null;
    super.dispose();
  }

  @action
  @override
  Future<void> upload() async {
    final chars = await uploadRequest((filters) => _onlineServices.getCharacters(filters));
    await _localServices.save(chars);
    if (_characters == null) {
      _characters = chars.asObservable();
    } else {
      _characters?.addAll(chars);
    }
  }

  @action
  @override
  Future<void> refresh() {
    _characters?.clear();
    toDefault();
    return upload();
  }

  @action
  Future<void> toggleFavorite(Character character) async {
    final isFavorite = _favorites?.contains(character) ?? false;
    if (isFavorite) {
      await _localServices.removeFavorite(character);
      _favorites?.remove(character);
    } else {
      await _localServices.addFavorite(character);
      _favorites?.add(character);
    }
  }
}
