import 'package:equatable/equatable.dart';

import '../../domain/entities/favorites.dart';

enum FavoriteStatus { loading, ready, error, message }

class FavoritesState extends Equatable {
  final FavoriteStatus status;
  final List<Favorites>? favoritesList;
  final String? msg;

  const FavoritesState._(this.status, this.favoritesList, this.msg);

  @override
  List<Object?> get props => [status, favoritesList, msg];

  const FavoritesState.initial() : this._(FavoriteStatus.loading, null, null);

  FavoritesState loading() => FavoritesState._(FavoriteStatus.loading, favoritesList, msg);

  FavoritesState ready(List<Favorites>? favoritesList) => FavoritesState._(FavoriteStatus.ready, favoritesList, msg);

  FavoritesState error(String msgError) => FavoritesState._(FavoriteStatus.error, favoritesList, msgError);

  FavoritesState message(String msg) => FavoritesState._(FavoriteStatus.message, favoritesList, msg);
}
