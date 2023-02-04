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
