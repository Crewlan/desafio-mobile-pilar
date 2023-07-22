import 'package:equatable/equatable.dart';

import '../../domain/entities/pronunciation.dart';

class PronunciationModel extends Equatable {
  final String? all;

  const PronunciationModel({
    this.all,
  });

  static Map<String, dynamic> toJson(PronunciationModel? e) {
    return {
      'all': e?.all,
    };
  }

  factory PronunciationModel.fromJson(Map<String, dynamic> json) => PronunciationModel(all: json['all']);

  factory PronunciationModel.fromEntity(Pronunciation? entity) => PronunciationModel(all: entity?.all);

  Pronunciation toEntity() => Pronunciation(all: all);

  @override
  List<Object?> get props => [all];
}
