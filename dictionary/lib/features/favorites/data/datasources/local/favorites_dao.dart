import 'package:dictionary/features/favorites/data/models/favorites_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavoritesDao {
  @Query('SELECT * FROM Favorites')
  Future<List<FavoritesModel>?> getFavorites();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavorites(List<FavoritesModel> favoritesList);

  @Query('DELETE FROM Favorites WHERE word = :word')
  Future<void> deleteFavorites(String word);

  @Query('DELETE FROM Favorites')
  Future<void> deleteAllFavorites();
}
