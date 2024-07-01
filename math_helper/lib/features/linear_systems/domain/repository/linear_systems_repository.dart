import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_response.dart';

abstract class LinearSystemsRepository {
  Future<Either<Failure, LinearSystemResponse>> solve(
      LinearSystemRequest request);
}
