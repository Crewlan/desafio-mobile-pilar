import 'package:sqflite/sqflite.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../models/favorites_model.dart';
import 'favorites_dao.dart';

abstract class IFavoritesLocalDatasource {
  Future<List<FavoritesModel>?> getFavorites();
  Future<void> cacheFavorites(List<FavoritesModel>? favoritesList);
  Future<void> deleteFavorites(String word);
  Future<void> deleteAllFavorites();
}

class FavoritesLocalDatasource extends IFavoritesLocalDatasource {
  final FavoritesDao favoritesDao;

  FavoritesLocalDatasource(this.favoritesDao);

  @override
  Future<void> cacheFavorites(List<FavoritesModel>? favoritesList) async {
    try {
      await favoritesDao.insertFavorites(favoritesList ?? []);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllFavorites() async {
    try {
      await favoritesDao.deleteAllFavorites();
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteFavorites(String word) async {
    try {
      await favoritesDao.deleteFavorites(word);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<List<FavoritesModel>?> getFavorites() async {
    try {
      final response = await favoritesDao.getFavorites();
      return response ?? [];
    } on DatabaseException {
      return [];
    }
  }
}
