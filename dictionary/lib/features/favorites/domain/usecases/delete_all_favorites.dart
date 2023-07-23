import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_favorites_repository.dart';

class DeleteAllFavorites {
  final IFavoritesRepository repository;

  DeleteAllFavorites(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.deleteAllFavorites();
  }
}
