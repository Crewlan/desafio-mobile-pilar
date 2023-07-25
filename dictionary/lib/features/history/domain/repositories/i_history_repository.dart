import 'package:dartz/dartz.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';

import '../../../../core/errors/failures.dart';

abstract class IHistoryRepository {
  Future<Either<Failure, List<History>?>> getHistory();
  Future<Either<Failure, String>> cacheHistory({List<History>? word});
  Future<Either<Failure, String>> deleteAllHistory();
}
