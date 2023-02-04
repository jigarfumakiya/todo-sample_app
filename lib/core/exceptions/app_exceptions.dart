import 'package:equatable/equatable.dart';

abstract class AppException implements Exception {}

class InvalidTokenException implements AppException {
  String cause;

  InvalidTokenException(this.cause);
}

class TokenExpiredException implements AppException {
  final String cause;

  TokenExpiredException(this.cause);
}

class ServerException implements Exception {}

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
