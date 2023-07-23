import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/ui_helper_extension.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/words_dictionary.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../widgets/worlds_card.dart';
import '../words_list_bloc/words_bloc.dart';
import '../words_list_bloc/words_state.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  WordsDictionary worldsDictionary = WordsDictionary();
  final _worldsBloc = sl<WordsBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WordsBloc, WordsState>(
          builder: (context, state) {
            switch (state.status) {
              case WordsStatus.ready:
                return _ready(context, state);
              case WordsStatus.error:
                return StyledErrorWidget(
                  msgError: state.message,
                  onRetry: () => _worldsBloc.add(GetWordsEvent()),
                );
              case WordsStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _ready(BuildContext context, WordsState state) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppStrings.worlds,
              style: GoogleFonts.inter(
                fontSize: 20,
                color: AppColors.darkest,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: context.height,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.worldList?.length,
              itemBuilder: (context, position) {
                var worldItem = state.worldList?[position];
                return WorldsCard(
                  worldText: worldItem,
                  onTap: () => Navigator.of(context).pushNamed(Routes.word, arguments: worldItem),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
