import 'package:bloc/bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/history.dart';
import '../../domain/usecases/delete_all_history.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/usecases/save_history.dart';
import 'history_state.dart';

part 'history_event.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final SaveHistory saveHistory;
  final GetHistory getHistory;
  final DeleteAllHistory deleteAllHistory;
  HistoryBloc(this.saveHistory, this.getHistory, this.deleteAllHistory) : super(HistoryState.initial()) {
    on<GetHistoryEvent>((event, emit) async {
      emit(state.loading());
      var fold = await getHistory();
      emit(
        fold.fold(
          (failure) => state.error(_mapHistoryFailureToString(failure)),
          (words) => state.ready(words),
        ),
      );
    });

    on<DeleteAllHistoryEvent>((event, emit) async {
      emit(state.loading());
      var fold = await deleteAllHistory();
      emit(
        fold.fold(
          (failure) => state.error(_mapHistoryFailureToString(failure)),
          (msg) => state.message(msg),
        ),
      );
    });

    on<SaveHistoryEvent>((event, emit) async {
      emit(state.loading());
      var fold = await saveHistory(event.words);
      emit(
        fold.fold(
          (failure) => state.error(_mapHistoryFailureToString(failure)),
          (msg) => state.message(msg),
        ),
      );
    });
  }

  String _mapHistoryFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return AppStrings.failureLoadWorldsHistory;

      default:
        return AppStrings.failureLoadServer;
    }
  }
}
