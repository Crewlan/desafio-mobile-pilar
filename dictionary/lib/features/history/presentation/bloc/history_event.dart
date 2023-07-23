part of 'history_bloc.dart';

abstract class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {}

class SaveHistoryEvent extends HistoryEvent {
  List<History>? words;

  SaveHistoryEvent({
    this.words,
  });
}

class DeleteAllHistoryEvent extends HistoryEvent {}
