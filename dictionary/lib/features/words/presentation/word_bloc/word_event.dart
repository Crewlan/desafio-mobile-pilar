part of 'word_bloc.dart';

abstract class WordEvent {}

class GetWordResponseEvent extends WordEvent {
  String? word;

  GetWordResponseEvent({
    this.word,
  });
}
