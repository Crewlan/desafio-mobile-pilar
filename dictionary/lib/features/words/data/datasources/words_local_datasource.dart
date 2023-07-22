import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/words_dictionary.dart';

abstract class IWordsLocalDatasource {
  Future<List<String>> getWorldsList();
}

class WordsLocalDatasource extends IWordsLocalDatasource {
  final WordsDictionary worldsDictionary = WordsDictionary();

  @override
  Future<List<String>> getWorldsList() async {
    try {
      await worldsDictionary.loadJson();
      var response = worldsDictionary.getWordsList;
      return response as List<String>;
    } on Exception {
      throw CacheException();
    }
  }
}
