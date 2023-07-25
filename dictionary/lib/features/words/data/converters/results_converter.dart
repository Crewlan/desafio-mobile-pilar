import 'dart:convert';

import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:floor/floor.dart';

class ResultsConverter extends TypeConverter<List<ResultsModel>?, String> {
  @override
  List<ResultsModel>? decode(String databaseValue) {
    return jsonDecode(databaseValue) != null
        ? (jsonDecode(databaseValue) as List).map((e) => ResultsModel.fromJson(e)).toList()
        : null;
  }

  @override
  String encode(List<ResultsModel>? value) {
    return jsonEncode(value?.map((e) => ResultsModel.toJson(e)).toList());
  }
}
