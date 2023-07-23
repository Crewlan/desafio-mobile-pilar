import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: wordsBloc..add(GetWordsEvent()),
            child: const HomeScreen(),
          ),
        );
      case Routes.word:
        return MaterialPageRoute(builder: (_) {
          var args = settings.arguments as WordDetailsScreenParams;
          return BlocProvider.value(
            value: wordBloc..add(GetWordResponseEvent(word: args.word)),
            child: WordDetailScreen.withArgs(args),
          );
        });
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
