part of 'favorite_bloc.dart';

abstract class FavoritesEvent {}

class GetFavoritesEvent extends FavoritesEvent {}

class SaveFavoritesEvent extends FavoritesEvent {
  List<Favorites>? favoritesList;
  SaveFavoritesEvent({
    this.favoritesList,
  });
}

class DeleteFavoritesEvent extends FavoritesEvent {
  String? word;
  DeleteFavoritesEvent({
    this.word,
  });
}
