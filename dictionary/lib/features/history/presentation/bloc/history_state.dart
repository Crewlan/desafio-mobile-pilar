import 'package:equatable/equatable.dart';

import '../../domain/entities/history.dart';

enum HistoryStatus { loading, ready, error, message }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<History>? words;
  final String? msg;

  const HistoryState._(this.status, this.words, this.msg);

  @override
  List<Object?> get props => [status, words, msg];

  HistoryState.initial() : this._(HistoryStatus.loading, [], null);

  HistoryState loading() => HistoryState._(HistoryStatus.loading, words, msg);

  HistoryState ready(List<History>? words) => HistoryState._(HistoryStatus.ready, words, msg);

  HistoryState error(String msgError) => HistoryState._(HistoryStatus.error, words, msgError);

  HistoryState message(String message) => HistoryState._(HistoryStatus.message, words, message);
}
