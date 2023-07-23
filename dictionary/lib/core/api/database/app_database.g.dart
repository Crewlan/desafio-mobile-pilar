// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WordsDao? _wordsDaoInstance;

  HistoryDao? _historyDaoInstance;

  FavoritesDao? _favoritesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ResponseWord` (`word` TEXT, `results` TEXT, `syllables` TEXT, `pronunciation` TEXT, `frequency` REAL, PRIMARY KEY (`word`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`word` TEXT, PRIMARY KEY (`word`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favorites` (`word` TEXT, `favorited` INTEGER, `response` TEXT, PRIMARY KEY (`word`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WordsDao get wordsDao {
    return _wordsDaoInstance ??= _$WordsDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  FavoritesDao get favoritesDao {
    return _favoritesDaoInstance ??= _$FavoritesDao(database, changeListener);
  }
}

class _$WordsDao extends WordsDao {
  _$WordsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _responseWordModelInsertionAdapter = InsertionAdapter(
            database,
            'ResponseWord',
            (ResponseWordModel item) => <String, Object?>{
                  'word': item.word,
                  'results': _resultsConverter.encode(item.results),
                  'syllables': _syllableConverter.encode(item.syllables),
                  'pronunciation':
                      _pronunciationConverter.encode(item.pronunciation),
                  'frequency': item.frequency
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ResponseWordModel> _responseWordModelInsertionAdapter;

  @override
  Future<ResponseWordModel?> getResponseWord(String word) async {
    return _queryAdapter.query('SELECT * FROM ResponseWord WHERE word = ?1',
        mapper: (Map<String, Object?> row) => ResponseWordModel(
            word: row['word'] as String?,
            results: _resultsConverter.decode(row['results'] as String),
            syllables: _syllableConverter.decode(row['syllables'] as String),
            pronunciation:
                _pronunciationConverter.decode(row['pronunciation'] as String),
            frequency: row['frequency'] as double?),
        arguments: [word]);
  }

  @override
  Future<void> deleteResponseWord(String word) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ResponseWord WHERE word = ?1',
        arguments: [word]);
  }

  @override
  Future<void> deleteAllResponses() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ResponseWord');
  }

  @override
  Future<void> insertResponseWord(ResponseWordModel responseWordModel) async {
    await _responseWordModelInsertionAdapter.insert(
        responseWordModel, OnConflictStrategy.replace);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _historyModelInsertionAdapter = InsertionAdapter(database, 'History',
            (HistoryModel item) => <String, Object?>{'word': item.word});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryModel> _historyModelInsertionAdapter;

  @override
  Future<List<HistoryModel>?> getHistory() async {
    return _queryAdapter.queryList('SELECT * FROM History',
        mapper: (Map<String, Object?> row) =>
            HistoryModel(word: row['word'] as String?));
  }

  @override
  Future<void> deleteAllHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM History');
  }

  @override
  Future<void> insertHistory(List<HistoryModel> word) async {
    await _historyModelInsertionAdapter.insertList(
        word, OnConflictStrategy.replace);
  }
}

class _$FavoritesDao extends FavoritesDao {
  _$FavoritesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoritesModelInsertionAdapter = InsertionAdapter(
            database,
            'Favorites',
            (FavoritesModel item) => <String, Object?>{
                  'word': item.word,
                  'favorited':
                      item.favorited == null ? null : (item.favorited! ? 1 : 0),
                  'response': _responseWordConverter.encode(item.response)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoritesModel> _favoritesModelInsertionAdapter;

  @override
  Future<List<FavoritesModel>?> getFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM Favorites',
        mapper: (Map<String, Object?> row) => FavoritesModel(
            word: row['word'] as String?,
            favorited: row['favorited'] == null
                ? null
                : (row['favorited'] as int) != 0,
            response:
                _responseWordConverter.decode(row['response'] as String)));
  }

  @override
  Future<void> deleteFavorites(String word) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Favorites WHERE word = ?1',
        arguments: [word]);
  }

  @override
  Future<void> deleteAllFavorites() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Favorites');
  }

  @override
  Future<void> insertFavorites(List<FavoritesModel> favoritesList) async {
    await _favoritesModelInsertionAdapter.insertList(
        favoritesList, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _responseWordConverter = ResponseWordConverter();
final _resultsConverter = ResultsConverter();
final _syllableConverter = SyllableConverter();
final _pronunciationConverter = PronunciationConverter();
final _listStringConverter = ListStringConverter();
