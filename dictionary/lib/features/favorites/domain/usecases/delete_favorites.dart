import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_favorites_repository.dart';

class DeleteFavorites {
  final IFavoritesRepository repository;

  DeleteFavorites(this.repository);

  Future<Either<Failure, String>> call(String? word) async {
    return await repository.deleteFavorites(word);
  }
}
