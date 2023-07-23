import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/favorites.dart';
import '../repositories/i_favorites_repository.dart';

class SaveFavorites {
  final IFavoritesRepository repository;

  SaveFavorites(this.repository);

  Future<Either<Failure, String>> call(List<Favorites>? favoritesList) async {
    return await repository.saveFavoritesList(favoritesList);
  }
}
