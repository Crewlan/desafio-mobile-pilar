import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_history_repository.dart';

class DeleteAllHistory {
  final IHistoryRepository repository;

  DeleteAllHistory(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.deleteAllHistory();
  }
}
