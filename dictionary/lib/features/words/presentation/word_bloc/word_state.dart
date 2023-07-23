import 'package:equatable/equatable.dart';

import '../../domain/entities/response_word.dart';

enum WordStatus { loading, ready, error, message }

class WordState extends Equatable {
  final WordStatus status;
  final ResponseWord? responseWord;
  final String? msg;

  const WordState._(this.status, this.responseWord, this.msg);

  @override
  List<Object?> get props => [status, responseWord, msg];

  const WordState.initial() : this._(WordStatus.loading, null, null);

  WordState loading() => WordState._(WordStatus.loading, responseWord, msg);

  WordState ready(ResponseWord? responseWord) => WordState._(WordStatus.ready, responseWord, msg);

  WordState error(String msgError) => WordState._(WordStatus.error, responseWord, msgError);

  WordState message(String msg) => WordState._(WordStatus.message, responseWord, msg);
}
