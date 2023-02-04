import 'package:equatable/equatable.dart';

abstract class AppException implements Exception {}

class InvaildTokenException implements AppException {
  String cause;

  InvaildTokenException(this.cause);
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
