import 'package:dartz/dartz.dart';
import 'package:dictionary/features/words/domain/entities/response_word.dart';

import '../../../../core/errors/failures.dart';

abstract class IWordsRepository {
  Future<Either<Failure, List<String>>> getWordsList();
  Future<Either<Failure, ResponseWord?>> getWord(String? word);
  Future<Either<Failure, String>> deleteWord(String? word);
  Future<Either<Failure, String>> deleteAllWord();
}
