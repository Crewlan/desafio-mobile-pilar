import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:dictionary/features/favorites/presentation/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/history/presentation/bloc/history_bloc.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/words/presentation/screens/word_detail_screen.dart';
import '../../features/words/presentation/word_bloc/word_bloc.dart';
import '../../features/words/presentation/words_list_bloc/words_bloc.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final wordsBloc = sl<WordsBloc>();
    final wordBloc = sl<WordBloc>();
    final historyBloc = sl<HistoryBloc>();
    final favoritesBloc = sl<FavoritesBloc>();

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments;
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: wordsBloc..add(GetWordsEvent())),
                BlocProvider.value(value: historyBloc..add(GetHistoryEvent())),
                BlocProvider.value(value: favoritesBloc..add(GetFavoritesEvent())),
              ],
              child: HomeScreen(
                index: args != null ? args as int : 0,
              ),
            );
          },
        );
      case Routes.word:
        return MaterialPageRoute(builder: (_) {
          var args = settings.arguments as WordDetailsScreenParams;
          return BlocProvider.value(
            value: wordBloc..add(GetWordResponseEvent(word: args.word)),
            child: WordDetailScreen.withArgs(args),
          );
        });
      case Routes.favoriteDetails:
        return MaterialPageRoute(
            builder: (_) => FavoriteDetailsScreen(
                  favorites: settings.arguments as Favorites,
                ));
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: 'error_default'),
          builder: (_) => const Scaffold(
            body: SafeArea(
                child: Center(
              child: Text('Erro reinicie o app'),
            )),
          ),
        );
    }
  }
}
