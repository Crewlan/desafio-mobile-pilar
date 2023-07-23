import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../domain/entities/history.dart';

@Entity(tableName: 'History')
class HistoryModel extends Equatable {
  @primaryKey
  final String? word;

  const HistoryModel({
    this.word,
  });

  static Map<String, dynamic> toJson(HistoryModel? e) {
    return {
      'word': e?.word,
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      word: json['word'],
    );
  }

  factory HistoryModel.fromEntity(History entity) {
    return HistoryModel(
      word: entity.word,
    );
  }

  History toEntity() => History(word: word);

  @override
  List<Object?> get props => [word];
}
