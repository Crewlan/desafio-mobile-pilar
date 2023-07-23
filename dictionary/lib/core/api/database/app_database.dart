import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../features/words/data/converters/pronunciation_converter.dart';
import '../../../features/words/data/converters/response_word_converter.dart';
import '../../../features/words/data/converters/results_converter.dart';
import '../../../features/words/data/converters/syllables_converter.dart';
import '../../../features/words/data/datasources/local/words_dao.dart';
import '../../../features/words/data/models/response_word_model.dart';

part 'app_database.g.dart';

@TypeConverters([
  ResponseWordConverter,
  ResultsConverter,
  SyllableConverter,
  PronunciationConverter,
])
@Database(version: 1, entities: [ResponseWordModel])
abstract class AppDatabase extends FloorDatabase {
  WordsDao get wordsDao;

  static final migration1to2 = Migration(
      1,
      2,
      (database) async => await database.execute(
          'CREATA TABLE IF NOT EXISTS `ResponseWord` (`word` TEXT, `results` TEXT, `syllables` TEXT, `pronunciation` TEXT, `frequency` TEXT)'));
}
