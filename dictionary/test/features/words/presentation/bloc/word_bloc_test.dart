import 'package:dartz/dartz.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:dictionary/features/words/domain/usecases/get_response_word.dart';
import 'package:dictionary/features/words/presentation/word_bloc/word_bloc.dart';
import 'package:dictionary/features/words/presentation/word_bloc/word_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWordsResponse extends Mock implements GetResponseWord {}

void main() {
  late MockGetWordsResponse mockGetWordsResponse;
  late WordBloc wordBloc;

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
    mockGetWordsResponse = MockGetWordsResponse();
    wordBloc = WordBloc(mockGetWordsResponse);
  });

  test('Should emit Loading and Ready state when usecase return response', () async {
    //Arrange
    when(() => mockGetWordsResponse('a')).thenAnswer((invocation) async => Right(response));

    //Act
    final result = [
      const WordState.initial().loading(),
      const WordState.initial().loading().ready(response),
    ];
    expectLater(wordBloc.stream.asBroadcastStream(), emitsInOrder(result)).then((value) => prints('Favorites print'));

    //Assert
    wordBloc.add(GetWordResponseEvent(word: 'a'));
  });
}
