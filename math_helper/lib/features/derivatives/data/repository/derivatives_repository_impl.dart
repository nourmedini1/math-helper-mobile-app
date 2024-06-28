import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/derivatives/data/api/derivatives_api.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/repository/derivatives_repository.dart';

class DerivativesRepositoryImpl extends DerivativesRepository {
  final Connectivity connectivity;
  final DerivativesApi derivativesApi;
  DerivativesRepositoryImpl(
      {required this.connectivity, required this.derivativesApi});

  @override
  Future<Either<Failure, DerivativeResponse>> numericDerivative(
      DerivativeRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await derivativesApi.numericDerivative(request);
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
  Future<Either<Failure, DerivativeResponse>> symbolicDerivative(
      DerivativeRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await derivativesApi.symbolicDerivative(request);
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
