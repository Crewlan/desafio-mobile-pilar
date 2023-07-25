import 'package:dictionary/core/routes/routes.dart';
import 'package:dictionary/features/favorites/domain/entities/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/extensions/ui_helper_extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../injection_container.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';

class FavoriteDetailsScreen extends StatefulWidget {
  final Favorites? favorites;

  const FavoriteDetailsScreen({super.key, this.favorites});

  @override
  State<FavoriteDetailsScreen> createState() => _FavoriteDetailScreenState();
}

class _FavoriteDetailScreenState extends State<FavoriteDetailsScreen> {
  FlutterTts ftts = FlutterTts();
  late bool favorite;
  final _favoritesBloc = sl<FavoritesBloc>();

  @override
  void initState() {
    favorite = widget.favorites?.favorited ?? false;
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
              onTap: () => Navigator.of(context).pushReplacementNamed(Routes.home, arguments: 2),
              child: const Icon(MdiIcons.close),
            ),
          ),
          body: _ready(context)),
    );
  }

  Widget _ready(BuildContext context) {
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
                    widget.favorites?.word ?? '',
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.favorites?.responseWord?.pronunciation?.all ?? '',
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
                        await ftts.speak(widget.favorites?.word ?? AppStrings.sorryAudio);
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
                              word: widget.favorites?.word,
                              responseWord: widget.favorites?.responseWord,
                              favorited: favorite,
                            ),
                          ]))
                        : _favoritesBloc.add(DeleteFavoritesEvent(word: widget.favorites?.word));
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
            widget.favorites?.responseWord?.results != null
                ? SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: widget.favorites?.responseWord?.results?.length,
                      itemBuilder: (context, position) {
                        var itemResult = widget.favorites?.responseWord?.results?[position];
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
          ],
        ),
      ),
    );
  }
}
