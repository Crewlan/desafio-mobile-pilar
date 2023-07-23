import 'dart:convert';

import 'package:dictionary/features/words/data/models/syllables_model.dart';
import 'package:floor/floor.dart';

class SyllableConverter extends TypeConverter<SyllablesModel?, String> {
  @override
  SyllablesModel? decode(String databaseValue) {
    return SyllablesModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(SyllablesModel? value) {
    return jsonEncode(SyllablesModel.toJson(value));
  }
}
