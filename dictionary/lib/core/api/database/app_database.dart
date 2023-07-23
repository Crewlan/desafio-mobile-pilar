import 'dart:async';

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
@Database(version: 1, entities: [ResponseWordModel, HistoryModel])
abstract class AppDatabase extends FloorDatabase {
  WordsDao get wordsDao;
  HistoryDao get historyDao;

  static final migration1to2 = Migration(
    1,
    2,
    (database) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `ResponseWord` (`word` TEXT, `results` TEXT, `syllables` TEXT, `pronunciation` TEXT, `frequency` TEXT, PRIMARY KEY(`word`))');
      await database.execute('CREATE TABLE IF NOT EXISTS History (`word` TEXT)');
    },
  );
}
