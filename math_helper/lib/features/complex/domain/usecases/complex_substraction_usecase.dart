import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/repository/complex_repository.dart';

class ComplexSubstractionUsecase {
  final ComplexRepository complexRepository;

  ComplexSubstractionUsecase({required this.complexRepository});

  Future<Either<Failure, ComplexOperationsResponse>> call(
      ComplexOperationsRequest request) async {
    return await complexRepository.substraction(request);
  }
}
