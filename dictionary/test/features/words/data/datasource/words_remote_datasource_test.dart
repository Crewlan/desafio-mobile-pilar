import 'package:dictionary/core/api/api_interceptor.dart';
import 'package:dictionary/core/api/url_creator.dart';
import 'package:dictionary/core/device/network_info.dart';
import 'package:dictionary/core/errors/exceptions.dart';
import 'package:dictionary/features/words/data/datasources/remote/words_remote_datasource.dart';
import 'package:dictionary/features/words/data/models/pronunciation_model.dart';
import 'package:dictionary/features/words/data/models/response_word_model.dart';
import 'package:dictionary/features/words/data/models/results_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockHttpClient extends Mock implements IHttpClient {}

class MockUrlCreator extends Mock implements IUrlCreator {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockHttpClient mockHttpClient;
  late MockUrlCreator mockUrlCreator;
  late WordsRemoteDatasource remoteDatasource;

  var responseWordModel = const ResponseWordModel(
    word: 'a',
    results: [
      ResultsModel(
        definition: 'a word',
        partOfSpeech: 'noun',
        synonyms: ['aa'],
        typeOf: ['aa'],
      )
    ],
    pronunciation: PronunciationModel(all: 'ei'),
    frequency: 7.28,
  );

  setUp(() {
    mockUrlCreator = MockUrlCreator();
    mockNetworkInfo = MockNetworkInfo();
    mockHttpClient = MockHttpClient();
    remoteDatasource = WordsRemoteDatasource(
      mockHttpClient,
      mockNetworkInfo,
      mockUrlCreator,
    );
    when(() => mockUrlCreator.create(
          endpoint: any(named: 'endpoint'),
          queryParameters: any(named: 'queryParameters'),
          pathSegments: any(named: 'pathSegments'),
          scheme: any(named: 'scheme'),
          hostKey: any(named: 'hostKey'),
          port: any(named: 'port'),
        )).thenAnswer((_) => 'www');
  });

  group('Network not connected', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('Should throw NetworkException when theres no internet connection in words rapid api', () async {
      expect(() => remoteDatasource.getResponseWord('a'), throwsA(isA<NetworkException>()));
    });
  });

  group('Internet OK', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('Should return words when returns status code 200', () async {
      //Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response(fixture('words.json'), 200));

      //Act
      final response = await remoteDatasource.getResponseWord('a');

      expect(response, responseWordModel);
    });

    test('should throw ServerException whe return 500 or another code', () async {
      //Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response('Server Error', 500));

      //Act
      //Assert
      expect(() => remoteDatasource.getResponseWord('a'), throwsA(isA<ServerException>()));
    });
  });
}
