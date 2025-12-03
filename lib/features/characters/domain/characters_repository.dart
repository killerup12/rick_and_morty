part of '../characters.dart';

class CharactersRepository {
  CharactersRepository({required CharactersServices onlineServices, required CharactersServicesWritable localServices})
    : _onlineServices = onlineServices,
      _localServices = localServices;

  final CharactersServices _onlineServices;
  final CharactersServicesWritable _localServices;

  Future<ListResponse<Character>> getCharacters(CharactersFilters filters) async {
    try {
      final result = await _onlineServices.getCharacters(filters);
      await _localServices.save(result.response);
      return result;
    } catch (_) {
      final result = await _localServices.getCharacters(filters);
      return result;
    }
  }
}
