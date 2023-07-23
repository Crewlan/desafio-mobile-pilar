import 'dart:async';

import 'package:dictionary/features/favorites/data/datasources/local/favorites_dao.dart';
import 'package:dictionary/features/favorites/data/models/favorites_model.dart';
import 'package:dictionary/features/history/data/models/history_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../features/history/data/datasources/history_dao.dart';
import '../../../features/words/data/converters/pronunciation_converter.dart';
import '../../../features/words/data/converters/response_word_converter.dart';
import '../../../features/words/data/converters/results_converter.dart';
import '../../../features/words/data/converters/syllables_converter.dart';
import '../../../features/words/data/datasources/local/words_dao.dart';
import '../../../features/words/data/models/response_word_model.dart';
import 'list_string_converter.dart';

part 'app_database.g.dart';

@TypeConverters([
  ResponseWordConverter,
  ResultsConverter,
  SyllableConverter,
  PronunciationConverter,
  ListStringConverter,
])
@Database(version: 3, entities: [ResponseWordModel, HistoryModel, FavoritesModel])
abstract class AppDatabase extends FloorDatabase {
  WordsDao get wordsDao;
  HistoryDao get historyDao;
  FavoritesDao get favoritesDao;

  static final migration1to2 = Migration(
    1,
    2,
    (database) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `ResponseWord` (`word` TEXT, `results` TEXT, `syllables` TEXT, `pronunciation` TEXT, `frequency` TEXT, PRIMARY KEY(`word`))');
      await database.execute('CREATE TABLE IF NOT EXISTS History (`word` TEXT)');
    },
  );

  static final migration2to3 = Migration(2, 3, (database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Favorites` (`word` TEXT, `favorited` BOOLEAN,`response` TEXT, PRIMARY KEY(`word`))');
  });
}
