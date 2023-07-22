import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/i_words_repository.dart';
import '../datasources/words_local_datasource.dart';

class WordsRepository extends IWordsRepository {
  final IWordsLocalDatasource worldsLocalDatasource;

  WordsRepository(this.worldsLocalDatasource);

  @override
  Future<Either<Failure, List<String>>> getWorldsList() async {
    try {
      final response = await worldsLocalDatasource.getWorldsList();
      return Right(response);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }
}
