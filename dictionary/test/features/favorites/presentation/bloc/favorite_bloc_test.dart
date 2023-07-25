import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/favorites/domain/usecases/delete_all_favorites.dart';
import 'package:dictionary/features/favorites/domain/usecases/delete_favorites.dart';
import 'package:dictionary/features/favorites/domain/usecases/get_favorites.dart';
import 'package:dictionary/features/favorites/domain/usecases/save_favorites.dart';
import 'package:dictionary/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:dictionary/features/favorites/presentation/bloc/favorite_state.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFavoritesList extends Mock implements GetFavorites {}

class MockSaveFavoritesList extends Mock implements SaveFavorites {}

class MockDeleteFavoritesList extends Mock implements DeleteFavorites {}

class MockDeleteAllFavoritesList extends Mock implements DeleteAllFavorites {}

void main() {
  late MockGetFavoritesList mockGetFavoritesList;
  late MockSaveFavoritesList mockSaveFavoritesList;
  late MockDeleteFavoritesList mockDeleteFavoritesList;
  late MockDeleteAllFavoritesList mockDeleteAllFavoritesList;
  late FavoritesBloc favoritesBloc;

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
    mockGetFavoritesList = MockGetFavoritesList();
    mockDeleteAllFavoritesList = MockDeleteAllFavoritesList();
    mockDeleteFavoritesList = MockDeleteFavoritesList();
    mockSaveFavoritesList = MockSaveFavoritesList();

    favoritesBloc = FavoritesBloc(
      mockGetFavoritesList,
      mockSaveFavoritesList,
      mockDeleteAllFavoritesList,
      mockDeleteFavoritesList,
    );
  });

  test('Should have Loading as Initial State', () async => expect(favoritesBloc.state, const FavoritesState.initial()));

  group('Tests for get favorites', () {
    test('Should emit Loading and Ready state when usecase return response', () async {
      //Arrange
      when(() => mockGetFavoritesList()).thenAnswer((invocation) async => Right(favList));

      //Act
      final result = [
        const FavoritesState.initial().loading(),
        const FavoritesState.initial().loading().ready(favList),
      ];
      expectLater(favoritesBloc.stream.asBroadcastStream(), emitsInOrder(result))
          .then((value) => prints('Favorites print'));

      //Assert
      favoritesBloc.add(GetFavoritesEvent());
    });

    test('Should emit Error state when usecases return Cache Failure', () async {
      //Arrange
      when(() => mockGetFavoritesList()).thenAnswer((_) async => Left(CacheFailure()));

      //Act
      final result = [
        const FavoritesState.initial().loading(),
        const FavoritesState.initial().loading().error(AppStrings.failureLoadWorldsFavorites),
      ];
      expectLater(favoritesBloc.stream.asBroadcastStream(), emitsInOrder(result));

      //Assert
      favoritesBloc.add(GetFavoritesEvent());
    });
  });
}
