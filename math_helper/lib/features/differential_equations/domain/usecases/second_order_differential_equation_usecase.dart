import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';
import 'package:math_helper/features/differential_equations/domain/repository/differential_equations_repository.dart';

class SecondOrderDifferentialEquationUsecase {
  final DifferentialEquationsRepository differentialEquationsRepository;

  const SecondOrderDifferentialEquationUsecase(
      {required this.differentialEquationsRepository});

  Future<Either<Failure, DifferentialEquationResponse>> call(
      DifferentialEquationRequest request) async {
    return await differentialEquationsRepository.secondOrder(request);
  }
}
