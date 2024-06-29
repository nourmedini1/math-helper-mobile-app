import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/differential_equations/data/api/differential_equations_api.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';
import 'package:math_helper/features/differential_equations/domain/repository/differential_equations_repository.dart';

class DifferentialEquationsRepositoryImpl
    extends DifferentialEquationsRepository {
  final Connectivity connectivity;
  final DifferentialEquationsApi differentialEquationsApi;

  DifferentialEquationsRepositoryImpl(
      {required this.connectivity, required this.differentialEquationsApi});
  @override
  Future<Either<Failure, DifferentialEquationResponse>> firstOrder(
      DifferentialEquationRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await differentialEquationsApi.firstOrder(request);
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
  Future<Either<Failure, DifferentialEquationResponse>> secondOrder(
      DifferentialEquationRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await differentialEquationsApi.secondOrder(request);
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
  Future<Either<Failure, DifferentialEquationResponse>> thirdOrder(
      DifferentialEquationRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await differentialEquationsApi.thirdOrder(request);
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
