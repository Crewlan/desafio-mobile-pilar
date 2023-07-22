import 'package:bloc/bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_worlds_list.dart';
import 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetWorldsList getWorldsList;
  HomeBloc(this.getWorldsList) : super(HomeState.initial()) {
    on<GetHomeEvent>((event, emit) async {
      emit(state.loading());
      var fold = await getWorldsList();
      emit(
        fold.fold(
          (failure) => state.error(_mapHomeFailureToString(failure)),
          (list) => state.ready(list),
        ),
      );
    });
  }

  String _mapHomeFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      //TODO adjust
      case CacheFailure:
        return 'Erro ao restaurar as palavras';
      default:
        return 'Erro tente novamente';
    }
  }
}
