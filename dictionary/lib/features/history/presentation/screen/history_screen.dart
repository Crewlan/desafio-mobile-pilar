import 'package:dictionary/core/extensions/ui_helper_extension.dart';
import 'package:dictionary/core/utils/app_colors.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/styled_error_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_state.dart';

class HistoryScreen extends StatelessWidget {
  final _historyBloc = sl<HistoryBloc>();
  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            switch (state.status) {
              case HistoryStatus.ready:
              case HistoryStatus.message:
                return _ready(context, state);
              case HistoryStatus.error:
                return StyledErrorWidget(
                  msgError: state.msg,
                  msgButtonRetry: AppStrings.tryAgain,
                  onRetry: () => _historyBloc.add(GetHistoryEvent()),
                );
              case HistoryStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _ready(BuildContext context, HistoryState state) {
    return state.words?.isEmpty == true
        ? const Center(
            child: Text('Your history is empty'),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppStrings.recent,
                  style: GoogleFonts.inter(fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.words?.length,
                  itemBuilder: (context, position) {
                    var item = state.words?.reversed.toList();
                    var historyItem = item?[position];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: context.width / 2,
                      constraints: BoxConstraints(minWidth: context.width / 1.6),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.darkest),
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.lightest,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(historyItem?.word ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
