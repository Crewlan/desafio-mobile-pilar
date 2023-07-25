import 'package:dartz/dartz.dart';
import 'package:dictionary/core/errors/failures.dart';
import 'package:dictionary/core/utils/app_strings.dart';
import 'package:dictionary/features/history/domain/entities/history.dart';
import 'package:dictionary/features/history/domain/usecases/delete_all_history.dart';
import 'package:dictionary/features/history/domain/usecases/get_history.dart';
import 'package:dictionary/features/history/domain/usecases/save_history.dart';
import 'package:dictionary/features/history/presentation/bloc/history_bloc.dart';
import 'package:dictionary/features/history/presentation/bloc/history_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeleteAllHistory extends Mock implements DeleteAllHistory {}

class MockGetHistory extends Mock implements GetHistory {}

class MockSaveHistory extends Mock implements SaveHistory {}

void main() {
  late MockDeleteAllHistory mockDeleteAllHistory;
  late MockGetHistory mockGetHistory;
  late MockSaveHistory mockSaveHistory;
  late HistoryBloc historyBloc;

  var history = const History(word: 'a');
  var historyList = [history];

  setUp(() {
    mockDeleteAllHistory = MockDeleteAllHistory();
    mockGetHistory = MockGetHistory();
    mockSaveHistory = MockSaveHistory();

    historyBloc = HistoryBloc(
      mockSaveHistory,
      mockGetHistory,
      mockDeleteAllHistory,
    );
  });

  group('Tests for get history', () {
    test('Should emit Loading and Ready state when usecase return response', () async {
      //Arrange
      when(() => mockGetHistory()).thenAnswer((invocation) async => Right(historyList));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().ready(historyList),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result))
          .then((value) => prints('Favorites print'));

      //Assert
      historyBloc.add(GetHistoryEvent());
    });

    test('Should emit Error state when usecases return Cache Failure', () async {
      //Arrange
      when(() => mockGetHistory()).thenAnswer((_) async => Left(CacheFailure()));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().error(AppStrings.failureLoadWorldsHistory),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result));

      //Assert
      historyBloc.add(GetHistoryEvent());
    });
  });
  group('Tests for save history', () {
    test('Should emit Loading and Ready state when usecase return response', () async {
      //Arrange
      when(() => mockSaveHistory()).thenAnswer((invocation) async => const Right(AppStrings.save));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().message(AppStrings.save),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result))
          .then((value) => prints('Favorites print'));

      //Assert
      historyBloc.add(SaveHistoryEvent());
    });

    test('Should emit Error state when usecases return Cache Failure', () async {
      //Arrange
      when(() => mockSaveHistory()).thenAnswer((_) async => Left(CacheFailure()));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().error(AppStrings.failureLoadWorldsHistory),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result));

      //Assert
      historyBloc.add(SaveHistoryEvent());
    });
  });

  group('Tests for Delete all history', () {
    test('Should emit Loading and Ready state when usecase return response', () async {
      //Arrange
      when(() => mockDeleteAllHistory()).thenAnswer((invocation) async => const Right(AppStrings.delete));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().message(AppStrings.delete),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result))
          .then((value) => prints('Favorites print'));

      //Assert
      historyBloc.add(DeleteAllHistoryEvent());
    });

    test('Should emit Error state when usecases return Cache Failure', () async {
      //Arrange
      when(() => mockDeleteAllHistory()).thenAnswer((_) async => Left(CacheFailure()));

      //Act
      final result = [
        HistoryState.initial().loading(),
        HistoryState.initial().loading().error(AppStrings.failureLoadWorldsHistory),
      ];
      expectLater(historyBloc.stream.asBroadcastStream(), emitsInOrder(result));

      //Assert
      historyBloc.add(DeleteAllHistoryEvent());
    });
  });
}
