import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_home_repository.dart';

class GetWorldsList {
  final IHomeRepository repository;

  GetWorldsList(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getWorldsList();
  }
}
