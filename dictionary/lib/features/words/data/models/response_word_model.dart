import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../domain/entities/response_word.dart';
import 'pronunciation_model.dart';
import 'results_model.dart';
import 'syllables_model.dart';

@Entity(tableName: 'ResponseWord')
class ResponseWordModel extends Equatable {
  @primaryKey
  final String? word;
  final List<ResultsModel>? results;
  final SyllablesModel? syllables;
  final PronunciationModel? pronunciation;
  final double? frequency;

  const ResponseWordModel({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  static Map<String, dynamic> toJson(ResponseWordModel? e) {
    return {
      'word': e?.word,
      'results': e?.results?.map((e) => ResultsModel.toJson(e)).toList(),
      'syllables': SyllablesModel.toJson(e?.syllables),
      'pronunciation': PronunciationModel.toJson(e?.pronunciation),
      'frequency': e?.frequency,
    };
  }

  factory ResponseWordModel.fromJson(Map<String, dynamic> json) {
    return ResponseWordModel(
      word: json['word'],
      results: json['results'] != null ? (json['results'] as List).map((e) => ResultsModel.fromJson(e)).toList() : null,
      syllables: json['syllables'] != null ? SyllablesModel.fromJson(json['syllables']) : null,
      pronunciation: json['pronunciation'] != null ? PronunciationModel.fromJson(json['pronunciation']) : null,
      frequency: json['frequency']?.toDouble(),
    );
  }

  factory ResponseWordModel.fromEntity(ResponseWord? entity) => ResponseWordModel(
        word: entity?.word,
        results: entity?.results?.map((e) => ResultsModel.fromEntity(e)).toList(),
        syllables: SyllablesModel.fromEntity(entity?.syllables),
        pronunciation: PronunciationModel.fromEntity(entity?.pronunciation),
        frequency: entity?.frequency,
      );

  ResponseWord toEntity() => ResponseWord(
        word: word,
        results: results?.map((e) => e.toEntity()).toList(),
        syllables: syllables?.toEntity(),
        pronunciation: pronunciation?.toEntity(),
        frequency: frequency,
      );

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
