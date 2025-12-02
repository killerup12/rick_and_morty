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
