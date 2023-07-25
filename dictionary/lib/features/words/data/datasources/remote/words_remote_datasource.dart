import 'dart:convert';

import 'package:dictionary/core/api/api_interceptor.dart';
import 'package:dictionary/core/api/endpoints.dart';
import 'package:dictionary/core/api/url_creator.dart';
import 'package:dictionary/core/device/network_info.dart';
import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';

abstract class IWordsRemoteDatasource {
  Future<ResponseWordModel?> getResponseWord(String? word);
}

class WordsRemoteDatasource implements IWordsRemoteDatasource {
  final IHttpClient httpClient;
  final INetworkInfo networkInfo;
  final IUrlCreator urlCreator;

  WordsRemoteDatasource(
    this.httpClient,
    this.networkInfo,
    this.urlCreator,
  );

  @override
  Future<ResponseWordModel?> getResponseWord(String? word) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final response = await httpClient.get(urlCreator.create(endpoint: '${Endpoints.words}$word'));
      switch (response.statusCode) {
        case 200:
          return ResponseWordModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        case 404:
          throw NotFoundException();
        default:
          throw ServerException();
      }
    } else {
      throw NetworkException();
    }
  }
}
