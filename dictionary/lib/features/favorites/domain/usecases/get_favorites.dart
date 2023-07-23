import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/favorites.dart';
import '../repositories/i_favorites_repository.dart';

class GetFavorites {
  final IFavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Favorites>?>> call() async {
    return await repository.getFavoritesList();
  }
}
