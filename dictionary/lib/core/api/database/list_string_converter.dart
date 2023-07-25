import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../features/history/data/models/history_model.dart';

class ListStringConverter extends TypeConverter<List<HistoryModel>?, String> {
  @override
  List<HistoryModel>? decode(String databaseValue) {
    return jsonDecode(databaseValue) != null
        ? (jsonDecode(databaseValue) as List).map((e) => HistoryModel.fromJson(e)).toList()
        : null;
  }

  @override
  String encode(List<HistoryModel>? value) {
    return jsonEncode(value?.map((e) => HistoryModel.toJson(e)).toList());
  }
}
