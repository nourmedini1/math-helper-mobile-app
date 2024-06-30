import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/data/models/product_response.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> symbolic(ProductRequest request);
  Future<Either<Failure, ProductResponse>> numeric(ProductRequest request);
}
