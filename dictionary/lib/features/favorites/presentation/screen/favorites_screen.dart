import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../../../words/presentation/widgets/words_card.dart';
import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favoritesBloc = sl<FavoritesBloc>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        switch (state.status) {
          case FavoriteStatus.ready:
            return _ready(context, state);
          case FavoriteStatus.error:
            return StyledErrorWidget(
              msgError: state.msg,
              msgButtonRetry: AppStrings.tryAgain,
              onRetry: () => _favoritesBloc.add(GetFavoritesEvent()),
            );
          case FavoriteStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    ));
  }

  Widget _ready(BuildContext context, FavoritesState state) {
    return state.favoritesList?.isEmpty == true
        ? const Center(
            child: Text("You don't have favorites yet"),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Below you can see your favorites list!',
                  style: GoogleFonts.inter(fontSize: 18),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.favoritesList?.length,
                  itemBuilder: (context, position) {
                    var item = state.favoritesList?.reversed.toList();
                    var favItem = item?[position];
                    return WordsCard(
                        worldText: favItem?.word,
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(Routes.favoriteDetails, arguments: favItem);
                          // historyList?.removeWhere((element) => element.word == wordItem);
                          // historyList?.add(History(word: wordItem));
                          // _historyBloc.add(SaveHistoryEvent(words: historyList));
                        });
                  },
                ),
                // ListView.builder(
                //   itemCount: state.favoritesList?.length,
                //   itemBuilder: (context, position) {
                //     var item = state.favoritesList?.reversed.toList();
                //     var favItem = item?[position];
                //     return Text(favItem?.word ?? '');
                //   },
                // ),
              ),
            ],
          );
  }
}
