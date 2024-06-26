import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';

abstract class DerivativesRepository {
  Future<Either<Failure, DerivativeResponse>> symbolicDerivative(
      DerivativeRequest request);

  Future<Either<Failure, DerivativeResponse>> numericDerivative(
      DerivativeRequest request);
}
