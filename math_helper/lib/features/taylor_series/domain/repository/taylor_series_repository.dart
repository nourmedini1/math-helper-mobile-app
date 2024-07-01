import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_response.dart';

abstract class TaylorSeriesRepository {
  Future<Either<Failure, TaylorSeriesResponse>> expand(
      TaylorSeriesRequest request);
}
