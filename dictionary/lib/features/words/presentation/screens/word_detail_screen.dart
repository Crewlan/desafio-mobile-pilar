import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/extensions/ui_helper_extension.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/styled_button.dart';
import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../word_bloc/word_bloc.dart';
import '../word_bloc/word_state.dart';

class WordDetailsScreenParams {
  final String? word;
  final List<String>? wordList;
  final int? position;

  WordDetailsScreenParams({this.word, this.wordList, this.position});
}

class WordDetailScreen extends StatefulWidget {
  static WordDetailScreen withArgs(WordDetailsScreenParams args) => WordDetailScreen(
        word: args.word,
        wordList: args.wordList,
        position: args.position,
      );

  final String? word;
  final List<String>? wordList;
  final int? position;

  const WordDetailScreen({super.key, this.word, this.wordList, this.position});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  FlutterTts ftts = FlutterTts();
  bool favorite = false;
  final _favoritesBloc = sl<FavoritesBloc>();

  @override
  void dispose() {
    super.dispose();
  }

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
              case WordStatus.message:
                return _ready(context, state);
              case WordStatus.error:
                return StyledErrorWidget(
                  msgError: state.msg,
                  onRetry: () => Navigator.of(context).pop(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.playAudio,
                      style: GoogleFonts.inter(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await ftts.setLanguage("en-US");
                        await ftts.setSpeechRate(0.2);
                        await ftts.speak(widget.word ?? AppStrings.sorryAudio);
                      },
                      child: const Icon(MdiIcons.play),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favorite = !favorite;
                    });
                    favorite == true
                        ? _favoritesBloc.add(SaveFavoritesEvent(favoritesList: [
                            Favorites(
                              word: widget.word,
                              responseWord: state.responseWord,
                              favorited: favorite,
                            )
                          ]))
                        : _favoritesBloc.add(DeleteFavoritesEvent(word: widget.word));
                  },
                  child: Icon(
                    favorite == true ? MdiIcons.heart : MdiIcons.heartOutline,
                    color: AppColors.redLightest,
                  ),
                )
              ],
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
                  widget.wordList?.first == widget.word
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 60,
                          width: 100,
                          child: StyledButton(
                            text: AppStrings.previous,
                            action: () {
                              var prevWord = widget.wordList?[widget.position! - 1];
                              Navigator.of(context).pushReplacementNamed(Routes.word,
                                  arguments: WordDetailsScreenParams(
                                    word: prevWord,
                                    position: widget.position! - 1,
                                    wordList: widget.wordList,
                                  ));
                            },
                          ),
                        ),
                  widget.wordList?.last == widget.word
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 60,
                          width: 100,
                          child: StyledButton(
                            text: AppStrings.next,
                            action: () {
                              var nextWord = widget.wordList?[widget.position! + 1];
                              Navigator.of(context).pushReplacementNamed(Routes.word,
                                  arguments: WordDetailsScreenParams(
                                    word: nextWord,
                                    position: widget.position! + 1,
                                    wordList: widget.wordList,
                                  ));
                            },
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
