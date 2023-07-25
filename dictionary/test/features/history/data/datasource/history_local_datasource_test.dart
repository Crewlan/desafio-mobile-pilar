import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/features/history/data/datasources/history_dao.dart';
import 'package:dictionary/features/history/data/datasources/history_local_datasource.dart';
import 'package:dictionary/features/history/data/models/history_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common/src/exception.dart';

class MockHistoryDao extends Mock implements HistoryDao {}

void main() {
  late MockHistoryDao mockHistoryDao;
  late HistoryLocalDatasource localDatasource;

  var historyModel = const HistoryModel(word: 'a');
  var historyList = [historyModel];

  setUp(() {
    mockHistoryDao = MockHistoryDao();
    localDatasource = HistoryLocalDatasource(mockHistoryDao);
  });

  test('Should return list of history', () async {
    //Arrange
    when(() => mockHistoryDao.getHistory()).thenAnswer((_) async => historyList);

    //Act
    final result = await localDatasource.getHistory();

    //Assert
    expect(result, historyList);
  });

  test('should throw CacheException when DAO throws a empty List', () async {
    //Arrange
    when(() => mockHistoryDao.getHistory()).thenThrow([]);

    //Act

    //Assert
    expect(() => localDatasource.getHistory(), throwsA([]));
  });

  test('Should save list of history', () async {
    //Arrange
    when(() => mockHistoryDao.insertHistory(historyList)).thenAnswer((_) async {});

    //Act
    await localDatasource.cacheHistory(word: historyList);

    //Assert
    verify(() => mockHistoryDao.insertHistory(historyList));
  });

  test('Should delete list of history', () async {
    //Arrange
    when(() => mockHistoryDao.deleteAllHistory()).thenAnswer((_) async {});

    //Act
    await localDatasource.deleteAllHistory();

    //Assert
    verify(() => mockHistoryDao.deleteAllHistory());
  });

  test('should throw CacheException when DAO throws Exception', () async {
    //Arrange
    when(() => mockHistoryDao.deleteAllHistory()).thenThrow(SqfliteDatabaseException('', null));

    //Act

    //Assert
    expect(localDatasource.deleteAllHistory(), throwsA(isA<CacheException>()));
  });
}
