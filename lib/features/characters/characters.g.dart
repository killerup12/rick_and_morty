// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharactersStore on _CharactersStoreBase, Store {
  late final _$_charactersAtom = Atom(name: '_CharactersStoreBase._characters', context: context);

  ObservableList<Character>? get characters {
    _$_charactersAtom.reportRead();
    return super._characters;
  }

  @override
  ObservableList<Character>? get _characters => characters;

  @override
  set _characters(ObservableList<Character>? value) {
    _$_charactersAtom.reportWrite(value, super._characters, () {
      super._characters = value;
    });
  }

  late final _$_loadCharactersAsyncAction = AsyncAction('_CharactersStoreBase._loadCharacters', context: context);

  @override
  Future<void> _loadCharacters() {
    return _$_loadCharactersAsyncAction.run(() => super._loadCharacters());
  }

  late final _$_CharactersStoreBaseActionController = ActionController(name: '_CharactersStoreBase', context: context);

  @override
  Future<void> upload() {
    final _$actionInfo = _$_CharactersStoreBaseActionController.startAction(name: '_CharactersStoreBase.upload');
    try {
      return super.upload();
    } finally {
      _$_CharactersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_CharactersStoreBaseActionController.startAction(name: '_CharactersStoreBase.refresh');
    try {
      return super.refresh();
    } finally {
      _$_CharactersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

mixin _$FavoritesStore on _FavoritesStoreBase, Store {
  late final _$_favoritesAtom = Atom(name: '_FavoritesStoreBase._favorites', context: context);

  ObservableList<Character>? get favorites {
    _$_favoritesAtom.reportRead();
    return super._favorites;
  }

  @override
  ObservableList<Character>? get _favorites => favorites;

  @override
  set _favorites(ObservableList<Character>? value) {
    _$_favoritesAtom.reportWrite(value, super._favorites, () {
      super._favorites = value;
    });
  }

  late final _$toggleAsyncAction = AsyncAction('_FavoritesStoreBase.toggle', context: context);

  @override
  Future<void> toggle(Character character) {
    return _$toggleAsyncAction.run(() => super.toggle(character));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
