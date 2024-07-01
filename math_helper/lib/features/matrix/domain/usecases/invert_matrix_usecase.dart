import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/repository/matrix_repository.dart';

class InvertMatrixUsecase {
  final MatrixRepository repository;

  InvertMatrixUsecase({required this.repository});

  Future<Either<Failure, MatrixResponse>> call(MatrixRequest request) async {
    return await repository.invert(request);
  }
}
