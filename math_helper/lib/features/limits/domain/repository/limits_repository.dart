import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';

abstract class LimitsRepository {
  Future<Either<Failure, LimitResponse>> single(LimitRequest request);
  Future<Either<Failure, LimitResponse>> double(LimitRequest request);
  Future<Either<Failure, LimitResponse>> triple(LimitRequest request);
}
