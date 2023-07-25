import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/favorites/domain/repositories/i_favorites_repository.dart';
import 'package:dictionary/features/favorites/domain/usecases/get_favorites.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFavoritesRepository extends Mock implements IFavoritesRepository {}

void main() {
  late MockIFavoritesRepository mockRepository;
  late GetFavorites getFavorites;
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

  var favList = [fav];

  setUp(() {
    mockRepository = MockIFavoritesRepository();
    getFavorites = GetFavorites(mockRepository);
  });

  test('should return a favorites list from the repository', () async {
    //Arrange
    when(() => mockRepository.getFavoritesList()).thenAnswer((_) async => Right<Failure, List<Favorites>?>(favList));

    //Act
    final result = await getFavorites();

    //Assert
    expect(result, Right<Failure, List<Favorites>?>(favList));
  });
}
