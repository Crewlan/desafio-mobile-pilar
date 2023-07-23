import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/history.dart';
import '../repositories/i_history_repository.dart';

class SaveHistory {
  final IHistoryRepository repository;

  SaveHistory(this.repository);

  Future<Either<Failure, String>> call(List<History>? word) async {
    return await repository.cacheHistory(word);
  }
}
