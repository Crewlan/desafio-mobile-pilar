import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/worlds_dictionary.dart';
import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WorldsDictionary worldsDictionary = WorldsDictionary();
  final _homeBloc = sl<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.ready:
              return _ready(state);
            case HomeStatus.error:
              return StyledErrorWidget(
                msgError: state.message,
                onRetry: () => _homeBloc.add(GetHomeEvent()),
              );
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Widget _ready(HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(state.worldList?.first ?? ''),
      ],
    );
  }
}
