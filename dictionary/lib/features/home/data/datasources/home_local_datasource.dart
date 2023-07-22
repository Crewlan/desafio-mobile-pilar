import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/worlds_dictionary.dart';

abstract class IHomeLocalDatasource {
  Future<List<String>> getWorldsList();
}

class HomeLocalDatasource extends IHomeLocalDatasource {
  final WorldsDictionary worldsDictionary = WorldsDictionary();

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
