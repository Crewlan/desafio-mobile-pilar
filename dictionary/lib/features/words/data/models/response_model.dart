import 'package:dictionary/features/words/domain/entities/response_word.dart';
import 'package:equatable/equatable.dart';

import 'pronunciation_model.dart';
import 'results_model.dart';
import 'syllables_model.dart';

class ResponseWordModel extends Equatable {
  final String? word;
  final List<ResultsModel>? resultsModel;
  final SyllablesModel? syllablesModel;
  final PronunciationModel? pronunciationModel;
  final double? frequency;

  const ResponseWordModel({
    this.word,
    this.resultsModel,
    this.syllablesModel,
    this.pronunciationModel,
    this.frequency,
  });

  static Map<String, dynamic> toJson(ResponseWordModel e) {
    return {
      'word': e.word,
      'results': e.resultsModel?.map((e) => ResultsModel.toJson(e)).toList(),
      'syllables': SyllablesModel.toJson(e.syllablesModel),
      'pronunciation': PronunciationModel.toJson(e.pronunciationModel),
      'frequency': e.frequency,
    };
  }

  factory ResponseWordModel.fromMap(Map<String, dynamic> json) {
    return ResponseWordModel(
      word: json['word'],
      resultsModel: json['results'] != null
          ? List<ResultsModel>.from(json['results']?.map((x) => ResultsModel.fromMap(x)))
          : null,
      syllablesModel: json['syllables'] != null ? SyllablesModel.fromJson(json['syllables']) : null,
      pronunciationModel: json['pronunciation'] != null ? PronunciationModel.fromJson(json['pronunciation']) : null,
      frequency: json['frequency']?.toDouble(),
    );
  }

  factory ResponseWordModel.fromEntity(ResponseWord entity) => ResponseWordModel(
        word: entity.word,
        resultsModel: entity.resultsModel?.map((e) => ResultsModel.fromEntity(e)).toList(),
        syllablesModel: SyllablesModel.fromEntity(entity.syllablesModel),
        pronunciationModel: PronunciationModel.fromEntity(entity.pronunciation),
        frequency: entity.frequency,
      );

  ResponseWord toEntity() => ResponseWord(
        word: word,
        resultsModel: resultsModel?.map((e) => e.toEntity()).toList(),
        syllablesModel: syllablesModel?.toEntity(),
        pronunciation: pronunciationModel?.toEntity(),
        frequency: frequency,
      );

  @override
  List<Object?> get props {
    return [
      word,
      resultsModel,
      syllablesModel,
      pronunciationModel,
      frequency,
    ];
  }
}
