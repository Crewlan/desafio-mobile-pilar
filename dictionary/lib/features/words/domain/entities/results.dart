import 'package:equatable/equatable.dart';

class Results extends Equatable {
  final String? definition;
  final String? partOfSpeech;
  final List<String>? synonyms;
  final List<String>? typeOf;
  final List<String>? hasTypes;
  final List<String>? derivation;
  final List<String>? examples;

  const Results({
    this.definition,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.hasTypes,
    this.derivation,
    this.examples,
  });

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
