import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class BadRequestFailure extends Failure {
  final String failureMessage;

  const BadRequestFailure({required this.failureMessage})
      : super(message: failureMessage);
}

class TimeoutFailure extends Failure {
  final String failureMessage;
  const TimeoutFailure({required this.failureMessage})
      : super(message: failureMessage);
}

class ConstraintViolationFailure extends Failure {
  final String failureMessage;
  const ConstraintViolationFailure({required this.failureMessage})
      : super(message: failureMessage);
}

class ServerFailure extends Failure {
  final String failureMessage;
  const ServerFailure({required this.failureMessage})
      : super(message: failureMessage);
}

class ConnectionUnavailableFailure extends Failure {
  final String failureMessage;
  const ConnectionUnavailableFailure({required this.failureMessage})
      : super(message: failureMessage);
}

class UnexpectedFailure extends Failure {
  final String failureMessage;
  const UnexpectedFailure({required this.failureMessage})
      : super(message: failureMessage);
}
