import 'package:equatable/equatable.dart';

enum WordsStatus { loading, ready, error }

class WordsState extends Equatable {
  final WordsStatus status;
  final List<String>? worldList;
  final String? message;

  const WordsState._(this.status, this.worldList, this.message);

  @override
  List<Object?> get props => [status, worldList, message];

  WordsState.initial() : this._(WordsStatus.loading, [], null);

  WordsState loading() => WordsState._(WordsStatus.loading, worldList, message);

  WordsState ready(List<String>? worldList) => WordsState._(WordsStatus.ready, worldList, message);

  WordsState error(String msgError) => WordsState._(WordsStatus.error, worldList, msgError);
}
