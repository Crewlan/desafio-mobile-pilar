import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/favorites/presentation/screen/favorites_screen.dart';
import 'package:dictionary/features/history/presentation/bloc/history_bloc.dart';
import 'package:dictionary/features/history/presentation/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/ui_helper_extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../injection_container.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../../../words/presentation/screens/words_screen.dart';

class HomeScreen extends StatefulWidget {
  final int? index;
  const HomeScreen({super.key, this.index});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _favoritesBloc = sl<FavoritesBloc>();
  final _historyBloc = sl<HistoryBloc>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.index ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          body: SizedBox(
            height: context.height,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueDarkest),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TabBar(
                    controller: _tabController,
                    padding: const EdgeInsets.only(top: 6),
                    labelColor: AppColors.blueDarkest,
                    indicatorColor: AppColors.blueDarkest,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: (position) {
                      position == 1 ? _historyBloc.add(GetHistoryEvent()) : null;
                      position == 2 ? _favoritesBloc.add(GetFavoritesEvent()) : null;
                    },
                    tabs: [
                      Text(AppStrings.worlds, style: GoogleFonts.inter(fontSize: 16)),
                      Text(AppStrings.history, style: GoogleFonts.inter(fontSize: 16)),
                      Text(AppStrings.favorites, style: GoogleFonts.inter(fontSize: 16)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      _buildPage(const WordsScreen()),
                      _buildPage(HistoryScreen()),
                      _buildPage(const FavoritesScreen()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(Widget? page) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: page,
      );
    });
  }
}
