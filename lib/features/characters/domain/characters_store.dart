part of '../characters.dart';

class CharactersStore = _CharactersStoreBase with _$CharactersStore;

abstract class _CharactersStoreBase with Store, RouteInjectable, ListControlsMixin<CharactersFilters> {
  _CharactersStoreBase({required CharactersRepository repository}) : _repository = repository;

  final CharactersRepository _repository;

  @override
  final filters = CharactersFilters();

  @readonly
  ObservableList<Character>? _characters;

  @override
  void init() {
    super.init();
    _loadCharacters();
  }

  @override
  void dispose() {
    _characters = null;
    super.dispose();
  }

  @action
  Future<void> _loadCharacters() async {
    final chars = await uploadRequest((filters) => _repository.getCharacters(filters));
    if (_characters == null) {
      _characters = chars.asObservable();
    } else {
      _characters?.addAll(chars);
    }
  }

  @action
  @override
  Future<void> upload() => _loadCharacters();

  @action
  @override
  Future<void> refresh() {
    _characters?.clear();
    toDefault();
    return upload();
  }
}
