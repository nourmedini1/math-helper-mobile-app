import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';
import 'package:math_helper/features/sum/domain/repository/sum_repository.dart';

class SymbolicSumUsecase {
  final SumRepository repository;

  const SymbolicSumUsecase({required this.repository});

  Future<Either<Failure, SumResponse>> call(SumRequest request) async {
    return await repository.symbolic(request);
  }
}
