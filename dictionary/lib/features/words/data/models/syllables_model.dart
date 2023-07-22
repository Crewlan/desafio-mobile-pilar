import 'package:equatable/equatable.dart';

import '../../domain/entities/syllables.dart';

class SyllablesModel extends Equatable {
  final int? count;
  final List<String>? list;

  const SyllablesModel({
    this.count,
    this.list,
  });

  static Map<String, dynamic> toJson(SyllablesModel? e) {
    return {
      'count': e?.count,
      'list': e?.list,
    };
  }

  factory SyllablesModel.fromJson(Map<String, dynamic> map) {
    return SyllablesModel(
      count: map['count'],
      list: List<String>.from(map['list']),
    );
  }

  factory SyllablesModel.fromEntity(Syllables? entity) {
    return SyllablesModel(
      count: entity?.count,
      list: entity?.list?.map((e) => e).toList(),
    );
  }

  Syllables toEntity() => Syllables(
        count: count,
        list: list?.map((e) => e).toList(),
      );

  @override
  List<Object?> get props => [count, list];
}
