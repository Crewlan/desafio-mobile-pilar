import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';
import 'package:dictionary/features/history/domain/repositories/i_history_repository.dart';
import 'package:dictionary/features/history/domain/usecases/save_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIHistoryRepository extends Mock implements IHistoryRepository {}

void main() {
  late MockIHistoryRepository mockIHistoryRepository;
  late SaveHistory saveHistory;

  var history = const History(word: 'a');
  var historyList = [history];

  setUp(() {
    mockIHistoryRepository = MockIHistoryRepository();
    saveHistory = SaveHistory(mockIHistoryRepository);
  });

  test('should save a history list from the repository', () async {
    //Arrange
    when(() => mockIHistoryRepository.cacheHistory(word: any(named: 'word')))
        .thenAnswer((_) async => const Right<Failure, String>(AppStrings.save));

    //Act
    final result = await saveHistory(word: historyList);

    //Assert
    expect(result, const Right<Failure, String>(AppStrings.save));
  });
}
