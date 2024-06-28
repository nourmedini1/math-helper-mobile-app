import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/repository/integrals_repository.dart';

import '../../data/models/integral_request.dart';

class TriplePrimitiveUsecase {
  final IntegralsRepository integralsRepository;
  const TriplePrimitiveUsecase({required this.integralsRepository});

  Future<Either<Failure, IntegralResponse>> call(
      IntegralRequest request) async {
    return await integralsRepository.triplePrimitive(request);
  }
}
