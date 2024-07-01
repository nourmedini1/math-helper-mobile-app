import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_response.dart';
import 'package:math_helper/features/taylor_series/domain/repository/taylor_series_repository.dart';

class ExpandTaylorSeriesUsecase {
  final TaylorSeriesRepository taylorSeriesRepository;

  const ExpandTaylorSeriesUsecase({required this.taylorSeriesRepository});

  Future<Either<Failure, TaylorSeriesResponse>> call(
      TaylorSeriesRequest request) async {
    return await taylorSeriesRepository.expand(request);
  }
}
