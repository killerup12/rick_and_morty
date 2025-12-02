part of '../database.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final instance = DatabaseHelper._();
  static Database? _database;
  static final _log = Logger('DatabaseHelper');

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final dbPath = path.join(await getDatabasesPath(), 'rick_and_morty.db');
    _log.info('Initializing database at: $dbPath');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE characters (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        status TEXT NOT NULL,
        species TEXT NOT NULL,
        type TEXT,
        gender TEXT NOT NULL,
        image TEXT NOT NULL,
        origin_id INTEGER,
        origin_name TEXT,
        location_id INTEGER,
        location_name TEXT,
        episode TEXT NOT NULL,
        created TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE favorites (
        character_id INTEGER PRIMARY KEY
      )
    ''');
    _log.info('Database created, version: $version');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _log.info('Upgrading database from version $oldVersion to $newVersion');
    // Миграции будут добавлены здесь
  }
}
