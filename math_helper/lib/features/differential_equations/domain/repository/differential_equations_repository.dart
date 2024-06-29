import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';

abstract class DifferentialEquationsRepository {
  Future<Either<Failure, DifferentialEquationResponse>> firstOrder(
      DifferentialEquationRequest request);

  Future<Either<Failure, DifferentialEquationResponse>> secondOrder(
      DifferentialEquationRequest request);

  Future<Either<Failure, DifferentialEquationResponse>> thirdOrder(
      DifferentialEquationRequest request);
}
