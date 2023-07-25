import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/history/domain/repositories/i_history_repository.dart';
import 'package:dictionary/features/history/domain/usecases/delete_all_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIHistoryRepository extends Mock implements IHistoryRepository {}

void main() {
  late MockIHistoryRepository mockIHistoryRepository;
  late DeleteAllHistory deleteAllHistory;

  setUp(() {
    mockIHistoryRepository = MockIHistoryRepository();
    deleteAllHistory = DeleteAllHistory(mockIHistoryRepository);
  });

  test('should return a history list from the repository', () async {
    //Arrange
    when(() => mockIHistoryRepository.deleteAllHistory())
        .thenAnswer((_) async => const Right<Failure, String>(AppStrings.delete));

    //Act
    final result = await deleteAllHistory();

    //Assert
    expect(result, const Right<Failure, String>(AppStrings.delete));
  });
}
