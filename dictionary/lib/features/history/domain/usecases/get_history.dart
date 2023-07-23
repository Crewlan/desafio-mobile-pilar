import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/history.dart';
import '../repositories/i_history_repository.dart';

class GetHistory {
  final IHistoryRepository repository;

  GetHistory(this.repository);

  Future<Either<Failure, List<History>?>> call() async {
    return await repository.getHistory();
  }
}
