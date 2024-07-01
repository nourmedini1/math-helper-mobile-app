import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_response.dart';
import 'package:math_helper/features/linear_systems/domain/repository/linear_systems_repository.dart';

class SolveLinearSystemUsecase {
  final LinearSystemsRepository repository;

  const SolveLinearSystemUsecase({required this.repository});

  Future<Either<Failure, LinearSystemResponse>> call(
      LinearSystemRequest request) async {
    return await repository.solve(request);
  }
}
