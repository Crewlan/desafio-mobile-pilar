import 'package:equatable/equatable.dart';

class Syllables extends Equatable {
  final int? count;
  final List<String>? list;

  const Syllables({this.count, this.list});

  @override
  List<Object?> get props => [count, list];
}
