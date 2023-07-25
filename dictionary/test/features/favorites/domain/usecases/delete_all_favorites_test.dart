import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/domain/repositories/i_favorites_repository.dart';
import 'package:dictionary/features/favorites/domain/usecases/delete_all_favorites.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFavoritesRepository extends Mock implements IFavoritesRepository {}

void main() {
  late MockIFavoritesRepository mockRepository;
  late DeleteAllFavorites deleteAllFavorites;

  setUp(() {
    mockRepository = MockIFavoritesRepository();
    deleteAllFavorites = DeleteAllFavorites(mockRepository);
  });

  test('should delete all favorites list from the repository', () async {
    //Arrange
    when(() => mockRepository.deleteAllFavorites())
        .thenAnswer((_) async => const Right<Failure, String>(AppStrings.delete));

    //Act
    final result = await deleteAllFavorites();

    //Assert
    expect(result, const Right<Failure, String>(AppStrings.delete));
  });
}
