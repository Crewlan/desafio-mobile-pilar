import 'package:dictionary/features/favorites/data/models/favorites_model.dart';
import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/words/data/models/pronunciation_model.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:dictionary/features/words/data/models/syllables_model.dart';
import 'package:dictionary/features/words/domain/entities/pronunciation.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:dictionary/features/words/domain/entities/results.dart';
import 'package:dictionary/features/words/domain/entities/syllables.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  var favModel = FavoritesModel(word: 'a', favorited: true, response: responseModel);

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

  var fav = Favorites(word: 'a', favorited: true, responseWord: response);

  test('Should convert Model to Entity', () async {
    //Arrange
    //Act
    final result = FavoritesModel.fromEntity(fav);
    //Assert
    expect(result, favModel);
  });
  test('Should convert Entity to Model', () async {
    //Arrange
    //Act
    final result = favModel.toEntity();
    //Assert
    expect(result, fav);
  });
}
