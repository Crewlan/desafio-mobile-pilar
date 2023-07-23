import 'package:equatable/equatable.dart';

import '../../../words/domain/entities/response_word.dart';

class Favorites extends Equatable {
  final String? word;
  final bool? favorited;
  final ResponseWord? responseWord;

  const Favorites({this.word, this.favorited, this.responseWord});

  @override
  List<Object?> get props => [
        word,
        favorited,
        responseWord,
      ];
}
