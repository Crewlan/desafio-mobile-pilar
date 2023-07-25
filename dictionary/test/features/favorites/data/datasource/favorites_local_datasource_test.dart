import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dictionary/features/favorites/data/datasources/local/favorites_dao.dart';
import 'package:dictionary/features/favorites/data/datasources/local/favorites_local_datasource.dart';
import 'package:dictionary/features/favorites/data/models/favorites_model.dart';
import "package:dictionary/features/words/data/models/pronunciation_model.dart";
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';

class MockFavoritesDao extends Mock implements FavoritesDao {}

void main() {
  late MockFavoritesDao mockFavoritesDao;
  late FavoritesLocalDatasource favoritesLocalDatasource;

  var response = const ResponseWordModel(
      word: 'a',
      results: [
        ResultsModel(
          definition: 'a word',
          partOfSpeech: 'noun',
          synonyms: ['aa'],
          typeOf: ['aa'],
        )
      ],
      pronunciation: PronunciationModel(all: 'eɪ'),
      frequency: 7.28);

  var fav = FavoritesModel(word: 'a', favorited: true, response: response);

  var favList = [fav];

  setUp(() {
    mockFavoritesDao = MockFavoritesDao();
    favoritesLocalDatasource = FavoritesLocalDatasource(mockFavoritesDao);
  });

  test('Should return list of favorites', () async {
    //Arrange
    when(() => mockFavoritesDao.getFavorites()).thenAnswer((_) async => favList);

    //Act
    final result = await favoritesLocalDatasource.getFavorites();

    //Assert
    expect(result, favList);
  });

  test('should throw CacheException when DAO throws a empty List', () async {
    //Arrange
    when(() => mockFavoritesDao.getFavorites()).thenThrow([]);

    //Act

    //Assert
    expect(() => favoritesLocalDatasource.getFavorites(), throwsA([]));
  });
}
