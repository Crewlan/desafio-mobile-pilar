import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/data/models/favorites_model.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/favorites.dart';
import '../../domain/repositories/i_favorites_repository.dart';
import '../datasources/local/favorites_local_datasource.dart';

class FavoritesRepository extends IFavoritesRepository {
  final IFavoritesLocalDatasource localDatasource;

  FavoritesRepository(this.localDatasource);

  @override
  Future<Either<Failure, String>> deleteAllFavorites() async {
    try {
      await localDatasource.deleteAllFavorites();
      return const Right(AppStrings.delete);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteFavorites({String? word}) async {
    try {
      await localDatasource.deleteFavorites(word: word ?? '');
      return const Right(AppStrings.delete);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Favorites>?>> getFavoritesList() async {
    try {
      final response = await localDatasource.getFavorites();
      var entity = response?.map((e) => e.toEntity()).toList();
      return Right(entity);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveFavoritesList({List<Favorites>? favoritesList}) async {
    try {
      var favModel = favoritesList?.map((e) => FavoritesModel.fromEntity(e)).toList();
      await localDatasource.cacheFavorites(favoritesList: favModel);
      return const Right(AppStrings.save);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
