import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/history/data/datasources/history_local_datasource.dart';
import 'package:dictionary/features/history/data/models/history_model.dart';
import 'package:dictionary/features/history/data/repositories/history_repository.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryLocalDatasource extends Mock implements HistoryLocalDatasource {}

void main() {
  late MockHistoryLocalDatasource mockHistoryLocalDatasource;
  late HistoryRepository repository;

  var historyModel = const HistoryModel(word: 'a');
  var historyModelList = [historyModel];

  var history = const History(word: 'a');
  var historyList = [history];

  setUp(() {
    mockHistoryLocalDatasource = MockHistoryLocalDatasource();
    repository = HistoryRepository(mockHistoryLocalDatasource);
  });

  test('Should return list of favorites when call is successfull ', () async {
    //Arrange
    when(() => mockHistoryLocalDatasource.getHistory()).thenAnswer((_) async => historyModelList);
    //Act
    //Assert
    var result = Right<dynamic, List<History>?>(historyList);
    expect(result, Right(historyList));
  });

  test('Should return list empty when throws cache exception', () async {
    //Arrange
    when(() => mockHistoryLocalDatasource.getHistory()).thenThrow(CacheException());

    //Act
    final result = await repository.getHistory();

    expect(result, Left(CacheFailure()));
  });

  test('Should return String when call delete is successfull ', () async {
    //Arrange
    when(() => mockHistoryLocalDatasource.deleteAllHistory()).thenAnswer((_) async => AppStrings.delete);
    //Act
    //Assert
    var result = const Right<dynamic, String>(AppStrings.delete);
    expect(result, const Right(AppStrings.delete));
  });

  test('Should return String when insert a cache is successfull ', () async {
    //Arrange
    when(() => mockHistoryLocalDatasource.cacheHistory(word: any(named: 'word')))
        .thenAnswer((_) async => AppStrings.save);
    //Act
    //Assert
    var result = const Right<dynamic, String>(AppStrings.save);
    expect(result, const Right(AppStrings.save));
  });
}
