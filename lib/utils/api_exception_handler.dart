import 'exceptions.dart';

class ApiExceptionHandler {
  static Exception handle(int statusCode) {
    switch (statusCode) {
      case 401:
        return UnauthorizedException('Unauthorized access');
      case 404:
        return NotFoundException('Resource not found');
      default:
        return ServerException('An error occurred');
    }
  }
}
