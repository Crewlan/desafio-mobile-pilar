import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<String>>> getWorldsList();
}
