import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:dictionary/features/words/domain/repositories/i_words_repository.dart';
import 'package:dictionary/features/words/domain/usecases/get_response_word.dart';

class MockIWordsRepository extends Mock implements IWordsRepository {}

void main() {
  late MockIWordsRepository mockIWordsRepository;
  late GetResponseWord getResponseWord;

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
    frequency: 7.28,
  );

  setUp(() {
    mockIWordsRepository = MockIWordsRepository();
    getResponseWord = GetResponseWord(mockIWordsRepository);
  });

  test('should delete all history from the repository', () async {
    //Arrange
    when(() => mockIWordsRepository.getWord('a')).thenAnswer((_) async => Right<Failure, ResponseWord?>(response));

    //Act
    final result = await getResponseWord('a');

    //Assert
    expect(result, Right<Failure, ResponseWord?>(response));
  });
}
