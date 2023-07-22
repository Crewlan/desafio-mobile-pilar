import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class IWordsRepository {
  Future<Either<Failure, List<String>>> getWorldsList();
}
