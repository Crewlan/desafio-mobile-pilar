import 'package:equatable/equatable.dart';

class Pronunciation extends Equatable {
  final String? all;

  const Pronunciation({
    this.all,
  });

  @override
  List<Object?> get props => [all];
}
