import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'results.dart';
import 'syllables.dart';

class ResponseWord extends Equatable {
  final String? word;
  final List<Results>? resultsModel;
  final Syllables? syllablesModel;
  final Pronunciation? pronunciation;
  final double? frequency;

  const ResponseWord({
    this.word,
    this.resultsModel,
    this.syllablesModel,
    this.pronunciation,
    this.frequency,
  });

  @override
  List<Object?> get props {
    return [
      word,
      resultsModel,
      syllablesModel,
      pronunciation,
      frequency,
    ];
  }
}
