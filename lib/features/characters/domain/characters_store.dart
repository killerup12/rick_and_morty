part of '../characters.dart';

class CharactersStore = _CharactersStoreBase with _$CharactersStore;

abstract class _CharactersStoreBase with Store, RouteInjectable, ListControlsMixin {
  _CharactersStoreBase({required CharactersServices onlineServices, required CharactersServices localServices})
    : _onlineServices = onlineServices,
      _localServices = localServices;

  final CharactersServices _onlineServices;
  final CharactersServices _localServices;

  @override
  final filters = CharactersFilters();

  @readonly
  ObservableList<Character>? _characters;

  @override
  void init() {
    super.init();
    uploadRequest((filters) => _onlineServices.getCharacters(filters))
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
    super.dispose();
  }

  @action
  @override
  Future<void> upload() async {
    final chars = await uploadRequest((filters) => _onlineServices.getCharacters(filters));
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
}
