import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';

abstract class FunctionPlottingRepository {
  Future<Either<Failure, PlotResponse>> plotFunction(PlotRequest request);
}
