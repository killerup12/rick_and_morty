part of '../characters.dart';

abstract interface class CharactersServices {
  Future<ListResponse<Character>> getCharacters(CharactersFilters filters);
}

abstract interface class CharactersServicesWritable extends CharactersServices implements DatabaseWritable<Character> {}
