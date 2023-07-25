import 'package:equatable/equatable.dart';

import '../../domain/entities/results.dart';

class ResultsModel extends Equatable {
  final String? definition;
  final String? partOfSpeech;
  final List<String>? synonyms;
  final List<String>? typeOf;
  final List<String>? hasTypes;
  final List<String>? derivation;
  final List<String>? examples;

  const ResultsModel({
    this.definition,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.hasTypes,
    this.derivation,
    this.examples,
  });

  static Map<String, dynamic> toJson(ResultsModel? e) {
    return {
      'definition': e?.definition,
      'partOfSpeech': e?.partOfSpeech,
      'synonyms': e?.synonyms,
      'typeOf': e?.typeOf,
      'hasTypes': e?.hasTypes,
      'derivation': e?.derivation,
      'examples': e?.examples,
    };
  }

  factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        definition: json['definition'],
        partOfSpeech: json['partOfSpeech'],
        synonyms: json['synonyms'] != null ? (json['synonyms'] as List).map((e) => e.toString()).toList() : null,
        typeOf: json['typeOf'] != null ? (json['typeOf'] as List).map((e) => e.toString()).toList() : null,
        hasTypes: json['hasTypes'] != null ? (json['hasTypes'] as List).map((e) => e.toString()).toList() : null,
        derivation: json['derivation'] != null ? (json['derivation'] as List).map((e) => e.toString()).toList() : null,
        examples: json['examples'] != null ? (json['examples'] as List).map((e) => e.toString()).toList() : null,
      );

  factory ResultsModel.fromEntity(Results? entity) => ResultsModel(
        definition: entity?.definition,
        partOfSpeech: entity?.partOfSpeech,
        synonyms: entity?.synonyms?.map((e) => e).toList(),
        typeOf: entity?.typeOf?.map((e) => e).toList(),
        hasTypes: entity?.hasTypes?.map((e) => e).toList(),
        derivation: entity?.derivation?.map((e) => e).toList(),
        examples: entity?.examples?.map((e) => e).toList(),
      );

  Results toEntity() => Results(
        definition: definition,
        partOfSpeech: partOfSpeech,
        synonyms: synonyms?.map((e) => e).toList(),
        typeOf: typeOf?.map((e) => e).toList(),
        hasTypes: hasTypes?.map((e) => e).toList(),
        derivation: derivation?.map((e) => e).toList(),
        examples: examples?.map((e) => e).toList(),
      );

  @override
  List<Object?> get props {
    return [
      definition,
      partOfSpeech,
      synonyms,
      typeOf,
      hasTypes,
      derivation,
      examples,
    ];
  }
}
