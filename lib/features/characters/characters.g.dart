// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharactersStore on _CharactersStoreBase, Store {
  late final _$_charactersAtom = Atom(
    name: '_CharactersStoreBase._characters',
    context: context,
  );

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

  late final _$uploadAsyncAction = AsyncAction(
    '_CharactersStoreBase.upload',
    context: context,
  );

  @override
  Future<void> upload() {
    return _$uploadAsyncAction.run(() => super.upload());
  }

  late final _$_CharactersStoreBaseActionController = ActionController(
    name: '_CharactersStoreBase',
    context: context,
  );

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_CharactersStoreBaseActionController.startAction(
      name: '_CharactersStoreBase.refresh',
    );
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
