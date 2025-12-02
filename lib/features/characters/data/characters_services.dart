part of '../characters.dart';

abstract interface class CharactersServices {
  Future<ListResponse<Character>> getCharacters(FilterQuery filters);
}
