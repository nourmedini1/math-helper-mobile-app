import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/repository/derivatives_repository.dart';

class NumericDerivativeUsecase {
  final DerivativesRepository derivativesRepository;

  const NumericDerivativeUsecase({required this.derivativesRepository});

  Future<Either<Failure, DerivativeResponse>> call(
      DerivativeRequest request) async {
    return await derivativesRepository.numericDerivative(request);
  }
}
