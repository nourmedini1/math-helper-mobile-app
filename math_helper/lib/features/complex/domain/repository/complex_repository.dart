import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/data/models/polar_form_response.dart';

abstract class ComplexRepository {
  Future<Either<Failure, ComplexOperationsResponse>> addition(
      ComplexOperationsRequest request);

  Future<Either<Failure, ComplexOperationsResponse>> multiplication(
      ComplexOperationsRequest request);

  Future<Either<Failure, ComplexOperationsResponse>> substraction(
      ComplexOperationsRequest request);

  Future<Either<Failure, PolarFormResponse>> getPolarForm(
      PolarFormRequest request);
}
