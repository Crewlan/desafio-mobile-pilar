import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_words_repository.dart';

class GetWordsList {
  final IWordsRepository repository;

  GetWordsList(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getWorldsList();
  }
}
