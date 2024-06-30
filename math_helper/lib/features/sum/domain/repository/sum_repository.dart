import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';

abstract class SumRepository {
  Future<Either<Failure, SumResponse>> symbolic(SumRequest request);
  Future<Either<Failure, SumResponse>> numeric(SumRequest request);
}
