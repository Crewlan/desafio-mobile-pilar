import 'dart:convert';

import 'package:floor/floor.dart';

import '../models/pronunciation_model.dart';

class PronunciationConverter extends TypeConverter<PronunciationModel?, String> {
  @override
  PronunciationModel? decode(String databaseValue) {
    return PronunciationModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(PronunciationModel? value) {
    return jsonEncode(PronunciationModel.toJson(value));
  }
}
