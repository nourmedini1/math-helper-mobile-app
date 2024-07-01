import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';

abstract class MatrixRepository {
  Future<Either<Failure, MatrixResponse>> invert(MatrixRequest request);
  Future<Either<Failure, MatrixResponse>> determinant(MatrixRequest request);
  Future<Either<Failure, MatrixResponse>> rank(MatrixRequest request);
  Future<Either<Failure, MatrixResponse>> eigen(MatrixRequest request);
  Future<Either<Failure, MatrixResponse>> add(MatrixRequest request);
  Future<Either<Failure, MatrixResponse>> multiply(MatrixRequest request);
}
