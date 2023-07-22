import 'dart:convert';

import 'package:flutter/services.dart';

class WorldsDictionary {
  int jsonLenght = 0;
  List<String> wordsList = [];

  Future loadJson() async {
    final String response = await rootBundle.loadString('assets/json/worlds_dictionary.json');

    if (response.isNotEmpty) {
      final bruteData = jsonDecode(response);
      Map data = bruteData;

      jsonLenght = data.keys.length;

      for (var element in data.keys) {
        wordsList.add(element);
      }

      return data.keys;
    } else {
      throw Exception("response is Empty");
    }
  }

  int get getJsonLenght {
    return jsonLenght;
  }

  List get getWordsList {
    return wordsList;
  }
}
