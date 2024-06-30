import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/data/models/product_response.dart';
import 'package:math_helper/features/product/domain/repository/product_repository.dart';

class NumericProductUsecase {
  final ProductRepository repository;

  const NumericProductUsecase({required this.repository});

  Future<Either<Failure, ProductResponse>> call(ProductRequest request) async {
    return await repository.numeric(request);
  }
}
