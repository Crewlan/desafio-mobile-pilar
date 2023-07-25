import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:dictionary/features/history/presentation/bloc/history_bloc.dart';
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
import '../../../history/domain/entities/history.dart';
import '../word_bloc/word_bloc.dart';
import '../word_bloc/word_state.dart';

enum TtsState { playing, stopped, paused, continued }

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
  late bool favorite;
  final _favoritesBloc = sl<FavoritesBloc>();
  final _historyBloc = sl<HistoryBloc>();

  int end = 0;
  TtsState ttsState = TtsState.stopped;

  @override
  void initState() {
    favorite = _favoritesBloc.state.favoritesList
            ?.firstWhere((element) => element.word == widget.word, orElse: () => const Favorites())
            .favorited ??
        false;

    ftts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    ftts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    ftts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      setState(() {
        end = endOffset;
      });
    });
    super.initState();
  }

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
            onTap: () => Navigator.of(context).pushReplacementNamed(Routes.home, arguments: 0),
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
    var historyList = _historyBloc.state.words;
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
                        await _speak();
                      },
                      child: const Icon(MdiIcons.play),
                    ),
                    _progressBar(end)
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
            state.responseWord?.results != null
                ? SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: state.responseWord?.results?.length,
                      itemBuilder: (context, position) {
                        var itemResult = state.responseWord?.results?[position];
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
                              historyList?.removeWhere((element) => element.word == prevWord);
                              historyList?.add(History(word: prevWord));
                              _historyBloc.add(SaveHistoryEvent(words: historyList));
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

                              historyList?.removeWhere((element) => element.word == nextWord);
                              historyList?.add(History(word: nextWord));
                              _historyBloc.add(SaveHistoryEvent(words: historyList));
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

  Future _speak() async {
    await ftts.setLanguage("en-US");
    await ftts.setSpeechRate(0.2);

    if (widget.word != null) {
      await ftts.awaitSpeakCompletion(true);
      await ftts.speak(widget.word ?? AppStrings.sorryAudio);
    } else {
      await ftts.speak(AppStrings.sorryAudio);
    }
  }

  Widget _progressBar(int end) => Container(
      width: 200,
      height: 20,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          backgroundColor: AppColors.blue,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blueDarkest),
          value: end / widget.word!.length,
        ),
      ));
}
