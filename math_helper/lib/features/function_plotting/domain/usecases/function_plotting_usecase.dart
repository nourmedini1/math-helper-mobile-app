import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/domain/repository/function_plotting_repository.dart';

class FunctionPlottingUsecase {
  final FunctionPlottingRepository functionPlottingRepository;
  const FunctionPlottingUsecase({
    required this.functionPlottingRepository,
  });

  Future<Either<Failure, PlotResponse>> call(PlotRequest request) async {
    return await functionPlottingRepository.plotFunction(request);
  }
}
