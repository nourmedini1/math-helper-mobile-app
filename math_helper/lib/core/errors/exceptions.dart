class BadRequestException implements Exception {
  final String message;
  BadRequestException({required this.message});
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class ConstraintViolationException implements Exception {
  final String message;
  ConstraintViolationException({required this.message});
}

class UnexpectedException implements Exception {
  final String message;
  UnexpectedException({required this.message});
}
