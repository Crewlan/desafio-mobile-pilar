import 'package:bloc/bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/get_words_list.dart';
import 'words_state.dart';

part 'words_event.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final GetWordsList getWorldsList;
  WordsBloc(this.getWorldsList) : super(WordsState.initial()) {
    on<GetWordsEvent>((event, emit) async {
      emit(state.loading());
      var fold = await getWorldsList();
      emit(
        fold.fold(
          (failure) => state.error(_mapWordsFailureToString(failure)),
          (list) => state.ready(list),
        ),
      );
    });
  }

  String _mapWordsFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return AppStrings.failureLoadWorlds;
      default:
        return AppStrings.failureLoadServer;
    }
  }
}
