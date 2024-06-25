import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/data/models/polar_form_response.dart';
import 'package:math_helper/features/complex/domain/repository/complex_repository.dart';

class PolarFormUsecase {
  final ComplexRepository complexRepository;

  PolarFormUsecase({required this.complexRepository});

  Future<Either<Failure, PolarFormResponse>> call(
      PolarFormRequest request) async {
    return await complexRepository.getPolarForm(request);
  }
}
