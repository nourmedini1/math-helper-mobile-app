import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';

abstract class IntegralsRepository {
  Future<Either<Failure, IntegralResponse>> singlePrimitive(
      IntegralRequest request);

  Future<Either<Failure, IntegralResponse>> doublePrimitive(
      IntegralRequest request);

  Future<Either<Failure, IntegralResponse>> triplePrimitive(
      IntegralRequest request);

  Future<Either<Failure, IntegralResponse>> singleIntegral(
      IntegralRequest request);

  Future<Either<Failure, IntegralResponse>> doubleIntegral(
      IntegralRequest request);

  Future<Either<Failure, IntegralResponse>> tripleIntegral(
      IntegralRequest request);
}
