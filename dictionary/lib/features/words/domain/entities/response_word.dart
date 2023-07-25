import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'results.dart';
import 'syllables.dart';

class ResponseWord extends Equatable {
  final String? word;
  final List<Results>? results;
  final Syllables? syllables;
  final Pronunciation? pronunciation;
  final double? frequency;

  const ResponseWord({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  @override
  List<Object?> get props {
    return [
      word,
      results,
      syllables,
      pronunciation,
      frequency,
    ];
  }
}
