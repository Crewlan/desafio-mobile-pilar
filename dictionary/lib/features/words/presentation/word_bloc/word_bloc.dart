import 'package:bloc/bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/get_response_word.dart';
import 'word_state.dart';

part 'word_event.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final GetResponseWord getResponseWord;
  WordBloc(this.getResponseWord) : super(const WordState.initial()) {
    on<GetWordResponseEvent>((event, emit) async {
      emit(state.loading());
      var fold = await getResponseWord(event.word);
      emit(
        fold.fold(
          (failure) => state.error(_mapWordFailureToString(failure)),
          (responseWord) => state.ready(responseWord),
        ),
      );
    });
  }

  String _mapWordFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return AppStrings.failureLoadWorlds;
      case NotFoundFailure:
        return AppStrings.failureNotFound;
      default:
        return AppStrings.failureLoadServer;
    }
  }
}
