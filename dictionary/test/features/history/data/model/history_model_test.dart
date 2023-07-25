import 'package:dictionary/features/history/data/models/history_model.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var historyModel = const HistoryModel(word: 'a');

  var history = const History(word: 'a');

  test('Should convert Model to Entity', () async {
    //Arrange
    //Act
    final result = HistoryModel.fromEntity(history);
    //Assert
    expect(result, historyModel);
  });
  test('Should convert Entity to Model', () async {
    //Arrange
    //Act
    final result = historyModel.toEntity();
    //Assert
    expect(result, history);
  });
}
