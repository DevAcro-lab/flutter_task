class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, [this.code]);

  @override
  String toString() {
    return "ApiException: $message (Code: $code)";
  }
}

class NetworkException extends ApiException {
  NetworkException(super.message, [super.code]);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message, [super.code]);
}

class ServerException extends ApiException {
  ServerException(super.message, [super.code]);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message, [super.code]);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message, [super.code]);
}
