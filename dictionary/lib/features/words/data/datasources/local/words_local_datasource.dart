import 'package:sqflite/sqflite.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/services/words_dictionary.dart';
import '../../models/response_word_model.dart';
import 'words_dao.dart';

abstract class IWordsLocalDatasource {
  Future<List<String>> getWordsList();

  Future<ResponseWordModel?> getResponseWord(String? word);
  Future<void> cacheResponseWord(ResponseWordModel responseWordModel);
  Future<void> deleteResponseWord(String? word);
  Future<void> deleteAllResponseWord();
}

class WordsLocalDatasource extends IWordsLocalDatasource {
  final WordsDictionary worldsDictionary = WordsDictionary();
  final WordsDao wordsDao;

  WordsLocalDatasource(this.wordsDao);

  @override
  Future<List<String>> getWordsList() async {
    try {
      await worldsDictionary.loadJson();
      var response = worldsDictionary.getWordsList;
      return response as List<String>;
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheResponseWord(ResponseWordModel responseWordModel) async {
    try {
      await wordsDao.insertResponseWord(responseWordModel);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllResponseWord() async {
    try {
      await wordsDao.deleteAllResponses();
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteResponseWord(String? word) async {
    try {
      await wordsDao.deleteResponseWord(word ?? '');
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<ResponseWordModel?> getResponseWord(String? word) async {
    try {
      final response = await wordsDao.getResponseWord(word ?? '');
      return response ?? const ResponseWordModel();
    } on DatabaseException {
      throw CacheException();
    }
  }
}
