import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/response_word.dart';
import '../../domain/repositories/i_words_repository.dart';
import '../datasources/local/words_local_datasource.dart';
import '../datasources/remote/words_remote_datasource.dart';

class WordsRepository extends IWordsRepository {
  final IWordsLocalDatasource localDatasource;
  final IWordsRemoteDatasource remoteDatasource;

  WordsRepository(
    this.remoteDatasource,
    this.localDatasource,
  );

  @override
  Future<Either<Failure, List<String>>> getWordsList() async {
    try {
      final response = await localDatasource.getWordsList();
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseWord?>> getWord(String? word) async {
    final localResponse = await localDatasource.getResponseWord(word);
    try {
      final remoteResponse = await remoteDatasource.getResponseWord(word);

      localResponse?.word == null ? localDatasource.cacheResponseWord(remoteResponse!) : null;

      var entity = localResponse?.word == null ? remoteResponse?.toEntity() : localResponse?.toEntity();

      return Right(entity);
    } on CacheException {
      throw Left(CacheFailure());
    } on ServerException {
      if (localResponse?.word?.isNotEmpty == true) {
        return Right(localResponse?.toEntity());
      } else {
        return Left(ServerFailure());
      }
    } on NetworkException {
      if (localResponse?.word?.isNotEmpty == true) {
        return Right(localResponse?.toEntity());
      } else {
        return Left(NetworkFailure());
      }
    } on NotFoundException {
      return Left(NotFoundFailure());
    }
  }
}
