import 'package:dictionary/features/words/data/datasources/local/words_dao.dart';
import 'package:dictionary/features/words/data/datasources/local/words_local_datasource.dart';
import 'package:dictionary/features/words/data/models/pronunciation_model.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWordsDao extends Mock implements WordsDao {}

void main() {
  late MockWordsDao mockWordsDao;
  late WordsLocalDatasource localDatasource;

  var response = const ResponseWordModel(
      word: 'a',
      results: [
        ResultsModel(
          definition: 'a word',
          partOfSpeech: 'noun',
          synonyms: ['aa'],
          typeOf: ['aa'],
        )
      ],
      pronunciation: PronunciationModel(all: 'ei'),
      frequency: 7.28);

  setUp(() {
    mockWordsDao = MockWordsDao();
    localDatasource = WordsLocalDatasource(mockWordsDao);
  });

  test('Should return list of favorites', () async {
    //Arrange
    when(() => mockWordsDao.getResponseWord('a')).thenAnswer((_) async => response);

    //Act
    final result = await localDatasource.getResponseWord('a');

    //Assert
    expect(result, response);
  });

  test('should throw CacheException when DAO throws a empty List', () async {
    //Arrange
    when(() => mockWordsDao.getResponseWord('a')).thenThrow([]);

    //Act

    //Assert
    expect(() => localDatasource.getResponseWord('a'), throwsA([]));
  });

  test('Should return save list of favorites', () async {
    //Arrange
    when(() => mockWordsDao.insertResponseWord(response)).thenAnswer((_) async {});

    //Act
    await localDatasource.cacheResponseWord(response);

    //Assert
    verify(() => mockWordsDao.insertResponseWord(response));
  });
}
