import 'package:bloc/bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/favorites.dart';
import '../../domain/usecases/delete_all_favorites.dart';
import '../../domain/usecases/delete_favorites.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/save_favorites.dart';

import 'favorite_state.dart';

part 'favorite_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final SaveFavorites saveFavorites;
  final DeleteAllFavorites deleteAllFavorites;
  final DeleteFavorites deleteFavorites;

  FavoritesBloc(this.getFavorites, this.saveFavorites, this.deleteAllFavorites, this.deleteFavorites)
      : super(const FavoritesState.initial()) {
    on<GetFavoritesEvent>((event, emit) async {
      emit(state.loading());
      var fold = await getFavorites();
      emit(
        fold.fold(
          (failure) => state.error(_mapFavoritesFailureToString(failure)),
          (list) => state.ready(list),
        ),
      );
    });

    on<SaveFavoritesEvent>((event, emit) async {
      emit(state.loading());
      var fold = await saveFavorites(event.favoritesList);
      emit(
        fold.fold(
          (failure) => state.error(_mapFavoritesFailureToString(failure)),
          (msg) => state.message(msg),
        ),
      );
    });

    on<DeleteFavoritesEvent>((event, emit) async {
      emit(state.loading());
      var fold = await deleteFavorites(event.word);
      emit(
        fold.fold(
          (failure) => state.error(_mapFavoritesFailureToString(failure)),
          (msg) => state.message(msg),
        ),
      );
    });

    on<DeleteAllFavoritesEvent>((event, emit) async {
      emit(state.loading());
      var fold = await deleteAllFavorites();
      emit(
        fold.fold(
          (failure) => state.error(_mapFavoritesFailureToString(failure)),
          (msg) => state.message(msg),
        ),
      );
    });
  }

  String _mapFavoritesFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return AppStrings.failureLoadWorldsHistory;

      default:
        return AppStrings.failureLoadServer;
    }
  }
}
