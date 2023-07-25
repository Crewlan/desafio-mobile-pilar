import 'package:dictionary/core/api/url_creator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UrlCreator urlCreator;

  setUp(() => urlCreator = UrlCreator());

  test(
      'Should return correct url with endpoint',
      () => () async {
            //Arrange
            //Act
            final result = urlCreator.create(endpoint: '/words/');

            //Assert
            expect(result, 'http://wordsapiv1.p.rapidapi.com/words/');
          });
}
