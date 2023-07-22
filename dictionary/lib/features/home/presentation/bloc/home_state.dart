import 'package:equatable/equatable.dart';

enum HomeStatus { loading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<String>? worldList;
  final String? message;

  const HomeState._(this.status, this.worldList, this.message);

  @override
  List<Object?> get props => [status, worldList, message];

  HomeState.initial() : this._(HomeStatus.loading, [], null);

  HomeState loading() => HomeState._(HomeStatus.loading, worldList, message);

  HomeState ready(List<String>? worldList) => HomeState._(HomeStatus.ready, worldList, message);

  HomeState error(String msgError) => HomeState._(HomeStatus.error, worldList, msgError);
}
