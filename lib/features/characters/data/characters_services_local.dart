part of '../characters.dart';

class CharactersServicesLocal implements CharactersServicesWritable {
  CharactersServicesLocal(this._db);

  final DatabaseHelper _db;
  static final _log = Logger('CharactersServicesLocal');

  @override
  Future<ListResponse<Character>> getCharacters(CharactersFilters filters) async {
    try {
      final database = await _db.database;
      final page = filters.page.value;
      const pageSize = 20;
      final offset = (page - 1) * pageSize;

      final maps = await database.query(
        'characters',
        where: _buildWhereClause(filters),
        whereArgs: _buildWhereArgs(filters),
        limit: pageSize,
        offset: offset,
      );

      final totalCount =
          Sqflite.firstIntValue(
            await database.rawQuery(
              'SELECT COUNT(*) FROM characters WHERE ${_buildWhereClause(filters) ?? '1=1'}',
              _buildWhereArgs(filters),
            ),
          ) ??
          0;

      final characters = maps.map(Character.fromDatabase).toList();
      final pages = (totalCount / pageSize).ceil();

      _log.info('Loaded ${characters.length} characters from database (page $page of $pages)');
      return ListResponse(pages: pages, count: totalCount, response: characters);
    } catch (e, stackTrace) {
      _log.severe('Failed to load characters from database', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ListResponse<Character>> getFavorites() async {
    try {
      final database = await _db.database;

      final maps = await database.rawQuery('''
        SELECT c.* FROM characters c
        INNER JOIN favorites f ON c.id = f.character_id
      ''');

      final characters = maps.map(Character.fromDatabase).toList();

      _log.info('Loaded ${characters.length} favorite characters from database');
      return ListResponse(pages: 1, count: characters.length, response: characters);
    } catch (e, stackTrace) {
      _log.severe('Failed to load favorite characters from database', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> save(List<Character> characters) async {
    try {
      final database = await _db.database;
      final batch = database.batch();

      for (final character in characters) {
        batch.insert('characters', character.toDatabase(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
      _log.info('Saved ${characters.length} characters to database');
    } catch (e, stackTrace) {
      _log.severe('Failed to save characters to database', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> delete(List<Character> items) async {
    try {
      final database = await _db.database;
      final batch = database.batch();

      for (final character in items) {
        batch.delete('characters', where: 'id = ?', whereArgs: [character.id]);
      }

      await batch.commit(noResult: true);
      _log.info('Deleted ${items.length} characters from database');
    } catch (e, stackTrace) {
      _log.severe('Failed to delete characters from database', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final database = await _db.database;
      await database.delete('characters');
      _log.info('Cleared all characters from database');
    } catch (e, stackTrace) {
      _log.severe('Failed to clear characters from database', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addFavorite(Character character) async {
    try {
      final database = await _db.database;
      await database.insert('favorites', {'character_id': character.id}, conflictAlgorithm: ConflictAlgorithm.ignore);
      _log.info('Added character ${character.id} to favorites');
    } catch (e, stackTrace) {
      _log.severe('Failed to add character to favorites', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(Character character) async {
    try {
      final database = await _db.database;
      await database.delete('favorites', where: 'character_id = ?', whereArgs: [character.id]);
      _log.info('Removed character ${character.id} from favorites');
    } catch (e, stackTrace) {
      _log.severe('Failed to remove character from favorites', e, stackTrace);
      rethrow;
    }
  }

  String? _buildWhereClause(FilterQuery filters) {
    final params = filters.queryParametersMapped;
    final conditions = <String>[];

    if (params['name'] != null) conditions.add('name LIKE ?');
    if (params['status'] != null) conditions.add('status = ?');
    if (params['species'] != null) conditions.add('species LIKE ?');
    if (params['gender'] != null) conditions.add('gender = ?');

    return conditions.isEmpty ? null : conditions.join(' AND ');
  }

  List<String>? _buildWhereArgs(FilterQuery filters) {
    final params = filters.queryParametersMapped;
    final args = <String>[];

    if (params['name'] != null) args.add('%${params['name']}%');
    if (params['status'] != null) args.add(params['status']!);
    if (params['species'] != null) args.add('%${params['species']}%');
    if (params['gender'] != null) args.add(params['gender']!);

    return args.isEmpty ? null : args;
  }
}
