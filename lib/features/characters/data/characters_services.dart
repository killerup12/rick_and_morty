part of '../characters.dart';

abstract interface class CharactersServices {
  Future<ListResponse<Character>> getCharacters(CharactersFilters filters);
}

abstract interface class CharactersFavoritesServices {
  Future<ListResponse<Character>> getFavorites();

  Future<void> addFavorite(Character character);

  Future<void> removeFavorite(Character character);
}

abstract interface class CharactersServicesWritable extends CharactersServices
    implements DatabaseWritable<Character>, CharactersFavoritesServices {}
