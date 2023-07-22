import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepository extends IHomeRepository {
  final IHomeLocalDatasource homeLocalDatasource;

  HomeRepository(this.homeLocalDatasource);

  @override
  Future<Either<Failure, List<String>>> getWorldsList() async {
    try {
      final response = await homeLocalDatasource.getWorldsList();
      return Right(response);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }
}
