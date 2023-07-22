import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class CacheFailure extends Failure {}

class NotFoundFailure extends Failure {}

class ReloadFailure extends Failure {}
