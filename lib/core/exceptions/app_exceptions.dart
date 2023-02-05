import 'package:equatable/equatable.dart';

/// AppException class
/// Abstract class for representing exceptions in the application
abstract class AppException implements Exception {}

/// Abstract class for representing failures in the application
/// It extends Equatable to enable comparison between instances.
/// The message property stores a description of the failure.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [];
}

/// InvalidTokenException class
/// Represents an exception caused by an invalid token
class InvalidTokenException implements AppException {
  String cause;

  InvalidTokenException(this.cause);
}

/// ServerException class
/// Represents an exception caused by a server error
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

/// ServerFailure class
/// Represents a failure caused by a server error
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// CacheFailure class
/// Represents a failure caused by a cache error
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
