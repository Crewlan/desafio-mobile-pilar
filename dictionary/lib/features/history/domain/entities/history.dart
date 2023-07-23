import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String? word;

  const History({this.word});

  @override
  List<Object?> get props => [word];
}
