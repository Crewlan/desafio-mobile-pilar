import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/words/presentation/bloc/worlds_bloc.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final worldsBloc = sl<WordsBloc>();
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: worldsBloc..add(GetWordsEvent()),
            child: const HomeScreen(),
          ),
        );
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
