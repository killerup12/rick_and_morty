part of '../characters.dart';

class CharactersServicesNetwork implements CharactersServices {
  @override
  Future<ListResponse<Character>> getCharacters(FilterQuery filters) async {
    final json = await ApiManager.instance.get(
      uri: Uri(
        scheme: 'https',
        host: 'rickandmortyapi.com',
        path: 'api/character',
        queryParameters: filters.queryParametersMapped,
      ),
    );

    return ListResponse.fromJson(json, (json['results'] as List).map((json) => Character.fromJson(json)).toList());
  }
}
