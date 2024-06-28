import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/repository/integrals_repository.dart';

class DoublePrimitiveUsecase {
  final IntegralsRepository integralsRepository;
  const DoublePrimitiveUsecase({required this.integralsRepository});

  Future<Either<Failure, IntegralResponse>> call(
      IntegralRequest request) async {
    return await integralsRepository.doublePrimitive(request);
  }
}
