import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/matrix/data/api/matrix_api.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/repository/matrix_repository.dart';

class MatrixRepositoryImpl extends MatrixRepository {
  final Connectivity connectivity;
  final MatrixApi matrixApi;

  MatrixRepositoryImpl({required this.connectivity, required this.matrixApi});

  @override
  Future<Either<Failure, MatrixResponse>> add(MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.add(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MatrixResponse>> determinant(
      MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.determinant(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MatrixResponse>> eigen(MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.eigen(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MatrixResponse>> invert(MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.invert(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MatrixResponse>> multiply(
      MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.multiply(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MatrixResponse>> rank(MatrixRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await matrixApi.rank(request);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failureMessage: serverFailureMessage));
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(failureMessage: e.message!));
      } on ConstraintViolationException catch (e) {
        return Left(ConstraintViolationFailure(failureMessage: e.message));
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(failureMessage: e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(failureMessage: e.message));
      }
    }
  }
}
