import 'package:dartz/dartz.dart';
import 'package:dictionary/features/words/data/datasources/local/words_local_datasource.dart';
import 'package:dictionary/features/words/data/datasources/remote/words_remote_datasource.dart';
import 'package:dictionary/features/words/data/models/pronunciation_model.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:dictionary/features/words/data/models/syllables_model.dart';
import 'package:dictionary/features/words/data/repositories/words_repository.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements IWordsRemoteDatasource {}

class MockLocalDataSource extends Mock implements IWordsLocalDatasource {}

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late WordsRepository repository;

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

  var responseModel = const ResponseWordModel(
      word: 'a',
      results: [
        ResultsModel(
          definition: 'a word',
          partOfSpeech: 'noun',
          synonyms: ['aa'],
          typeOf: ['aa'],
        )
      ],
      syllables: SyllablesModel(),
      pronunciation: PronunciationModel(all: 'ei'),
      frequency: 7.28);

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = WordsRepository(mockRemoteDataSource, mockLocalDataSource);
  });

  test('should return word when call is successfull', () async {
    //Arrange
    when(() => mockRemoteDataSource.getResponseWord('a')).thenAnswer((_) async => responseModel);
    when(() => mockLocalDataSource.cacheResponseWord(responseModel)).thenAnswer((invocation) async {});
    when(() => mockLocalDataSource.getResponseWord('a')).thenAnswer((invocation) async => responseModel);
    //Act
    final result = await repository.getWord('a');
    //Assert

    expect(result, Right(response));
  });
}
