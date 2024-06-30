import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';
import 'package:math_helper/features/limits/domain/repository/limits_repository.dart';

class DoubleLimitUsecase {
  final LimitsRepository limitsRepository;

  const DoubleLimitUsecase({required this.limitsRepository});

  Future<Either<Failure, LimitResponse>> call(LimitRequest request) async {
    return await limitsRepository.double(request);
  }
}
