import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/response_word.dart';
import '../repositories/i_words_repository.dart';

class GetResponseWord {
  final IWordsRepository repository;

  GetResponseWord(this.repository);

  Future<Either<Failure, ResponseWord?>> call(String? word) async {
    return await repository.getWord(word);
  }
}
