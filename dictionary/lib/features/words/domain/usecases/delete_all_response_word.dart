import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_words_repository.dart';

class DeleteAllResponseWord {
  final IWordsRepository repository;

  DeleteAllResponseWord(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.deleteAllWord();
  }
}
