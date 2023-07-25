import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/domain/repositories/i_favorites_repository.dart';
import 'package:dictionary/features/favorites/domain/usecases/delete_favorites.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFavoritesRepository extends Mock implements IFavoritesRepository {}

void main() {
  late MockIFavoritesRepository mockRepository;
  late DeleteFavorites deleteFavorites;

  setUp(() {
    mockRepository = MockIFavoritesRepository();
    deleteFavorites = DeleteFavorites(mockRepository);
  });

  test('should delete a favorites item from the repository', () async {
    //Arrange
    when(() => mockRepository.deleteFavorites(word: any(named: 'word')))
        .thenAnswer((_) async => const Right<Failure, String>(AppStrings.delete));

    //Act
    final result = await deleteFavorites(word: 'a');

    //Assert
    expect(result, const Right<Failure, String>(AppStrings.delete));
  });
}
