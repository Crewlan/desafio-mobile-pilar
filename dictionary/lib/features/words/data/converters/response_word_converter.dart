import 'dart:convert';

import 'package:floor/floor.dart';

import '../models/response_word_model.dart';

class ResponseWordConverter extends TypeConverter<ResponseWordModel?, String> {
  @override
  ResponseWordModel? decode(String databaseValue) {
    return ResponseWordModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(ResponseWordModel? value) {
    return jsonEncode(ResponseWordModel.toJson(value));
  }
}
