import 'package:dictionary/core/routes/routes.dart';
import 'package:dictionary/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/screen/home_screen.dart';
import '../../injection_container.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final homeBloc = sl<HomeBloc>();
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: homeBloc..add(GetHomeEvent()),
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
