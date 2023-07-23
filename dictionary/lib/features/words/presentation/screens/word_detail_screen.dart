import 'package:dictionary/core/widgets/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/extensions/ui_helper_extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../word_bloc/word_bloc.dart';
import '../word_bloc/word_state.dart';

class WordDetailsScreenParams {
  final String? word;
  final List<String>? wordList;

  WordDetailsScreenParams(this.word, this.wordList);
}

class WordDetailScreen extends StatefulWidget {
  static WordDetailScreen withArgs(WordDetailsScreenParams args) => WordDetailScreen(
        word: args.word,
        wordList: args.wordList,
      );

  final String? word;
  final List<String>? wordList;

  const WordDetailScreen({super.key, this.word, this.wordList});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  final _wordBloc = sl<WordBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(MdiIcons.close),
          ),
        ),
        body: BlocBuilder<WordBloc, WordState>(
          builder: (context, state) {
            switch (state.status) {
              case WordStatus.ready:
                return _ready(context, state);
              case WordStatus.error:
                return StyledErrorWidget(
                  msgError: state.msg,
                  onRetry: () => _wordBloc.add(GetWordResponseEvent(word: widget.word)),
                );
              case WordStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _ready(BuildContext context, WordState state) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              width: context.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.darkest),
                color: AppColors.purpleLightest,
              ),
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    state.responseWord?.word ?? '',
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.responseWord?.pronunciation?.all ?? '',
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.meaning,
              style: GoogleFonts.inter(
                fontSize: 20,
                color: AppColors.darkest,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            state.responseWord?.resultsModel != null
                ? SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: state.responseWord?.resultsModel?.length,
                      itemBuilder: (context, position) {
                        var itemResult = state.responseWord?.resultsModel?[position];
                        return Text(
                          '${itemResult?.partOfSpeech ?? ''} - ${itemResult?.definition ?? ''}',
                          style: GoogleFonts.inter(fontSize: 14, color: AppColors.darkest),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    child: Text(
                      AppStrings.errorMeaning,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.darkest,
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 100,
                    child: StyledButton(
                      text: 'back',
                      action: () {},
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 100,
                    child: StyledButton(
                      text: 'next',
                      action: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
