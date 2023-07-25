import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';
import 'package:dictionary/features/history/domain/repositories/i_history_repository.dart';
import 'package:dictionary/features/history/domain/usecases/get_history.dart';

import 'delete_all_history_test.dart';

class MockIHistoryFavorites extends Mock implements IHistoryRepository {}

void main() {
  late MockIHistoryRepository mockIHistoryRepository;
  late GetHistory getHistory;

  var history = const History(word: 'a');
  var historyList = [history];

  setUp(() {
    mockIHistoryRepository = MockIHistoryRepository();
    getHistory = GetHistory(mockIHistoryRepository);
  });

  test('should delete all history from the repository', () async {
    //Arrange
    when(() => mockIHistoryRepository.getHistory())
        .thenAnswer((_) async => Right<Failure, List<History>?>(historyList));

    //Act
    final result = await getHistory();

    //Assert
    expect(result, Right<Failure, List<History>?>(historyList));
  });
}
