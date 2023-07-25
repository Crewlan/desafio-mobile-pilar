import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/data/datasources/local/favorites_local_datasource.dart';
import 'package:dictionary/features/favorites/data/models/favorites_model.dart';
import 'package:dictionary/features/favorites/data/repositories/favorites_repository.dart';
import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/words/data/models/pronunciation_model.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:dictionary/features/words/data/models/syllables_model.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesLocalDatasource extends Mock implements IFavoritesLocalDatasource {}

void main() {
  late FavoritesRepository favoritesRepository;
  late MockFavoritesLocalDatasource mockFavoritesLocalDatasource;

  var responseModel = const ResponseWordModel(
      word: 'a',
      results: [
        ResultsModel(
          definition: 'a word',
          partOfSpeech: 'noun',
          synonyms: ['aa'],
          typeOf: ['aa'],
        )
      ],
      syllables: SyllablesModel(),
      pronunciation: PronunciationModel(all: 'ei'),
      frequency: 7.28);

  var favModel = FavoritesModel(word: 'a', favorited: true, response: responseModel);

  var response = const ResponseWord(
      word: 'a',
      results: [
        Results(
          definition: 'a word',
          partOfSpeech: 'noun',
          synonyms: ['aa'],
          typeOf: ['aa'],
        )
      ],
      syllables: Syllables(),
      pronunciation: Pronunciation(all: 'ei'),
      frequency: 7.28);

  var fav = Favorites(word: 'a', favorited: true, responseWord: response);

  setUp(() {
    mockFavoritesLocalDatasource = MockFavoritesLocalDatasource();
    favoritesRepository = FavoritesRepository(mockFavoritesLocalDatasource);
  });

  test('Should return list of favorites when call is successfull ', () async {
    //Arrange
    when(() => mockFavoritesLocalDatasource.getFavorites()).thenAnswer((_) async => [favModel]);
    //Act
    //Assert
    var result = Right<dynamic, Favorites>(fav);
    expect(result, Right(fav));
  });

  test('Should return list empty when throws cache exception', () async {
    //Arrange
    when(() => mockFavoritesLocalDatasource.getFavorites()).thenThrow(CacheException());

    //Act
    final result = await favoritesRepository.getFavoritesList();

    expect(result, Left(CacheFailure()));
  });

  test('Should return String when insert a cache is successfull ', () async {
    //Arrange
    when(() => mockFavoritesLocalDatasource.cacheFavorites(favoritesList: any(named: 'favoritesList')))
        .thenAnswer((_) async => AppStrings.save);
    //Act
    //Assert
    var result = const Right<dynamic, String>(AppStrings.save);
    expect(result, const Right(AppStrings.save));
  });

  test('Should return String when call delete all is successfull ', () async {
    //Arrange
    when(() => mockFavoritesLocalDatasource.deleteFavorites(word: any(named: 'word')))
        .thenAnswer((_) async => AppStrings.delete);
    //Act
    //Assert
    var result = const Right<dynamic, String>(AppStrings.delete);
    expect(result, const Right(AppStrings.delete));
  });
}
