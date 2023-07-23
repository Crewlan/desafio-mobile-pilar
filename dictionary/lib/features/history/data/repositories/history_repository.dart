import 'package:dartz/dartz.dart';
import 'package:dictionary/features/history/data/models/history_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/history.dart';
import '../../domain/repositories/i_history_repository.dart';
import '../datasources/history_local_datasource.dart';

class HistoryRepository extends IHistoryRepository {
  final IHistoryLocalDatasource localDatasource;

  HistoryRepository(this.localDatasource);

  @override
  Future<Either<Failure, String>> cacheHistory(List<History>? word) async {
    try {
      var model = word?.map((e) => HistoryModel.fromEntity(e)).toList();
      await localDatasource.cacheHistory(model);
      return const Right(AppStrings.save);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteAllHistory() async {
    try {
      await localDatasource.deleteAllHistory();
      return const Right(AppStrings.delete);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<History>?>> getHistory() async {
    try {
      final response = await localDatasource.getHistory();
      var entity = response?.map((e) => e.toEntity()).toList();
      return Right(entity);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
