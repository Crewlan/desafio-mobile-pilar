import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/favorites.dart';

abstract class IFavoritesRepository {
  Future<Either<Failure, List<Favorites>?>> getFavoritesList();
  Future<Either<Failure, String>> saveFavoritesList({List<Favorites>? favoritesList});
  Future<Either<Failure, String>> deleteFavorites({String? word});
  Future<Either<Failure, String>> deleteAllFavorites();
}
