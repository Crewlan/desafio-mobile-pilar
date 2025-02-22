import 'package:floor/floor.dart';

import '../../models/response_word_model.dart';

@dao
abstract class WordsDao {
  @Query('SELECT * FROM ResponseWord WHERE word = :word')
  Future<ResponseWordModel?> getResponseWord(String word);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertResponseWord(ResponseWordModel responseWordModel);
}
