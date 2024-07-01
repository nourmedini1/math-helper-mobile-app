import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/linear_systems/data/api/linear_systems_api.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_response.dart';
import 'package:math_helper/features/linear_systems/domain/repository/linear_systems_repository.dart';

class LinearSystemsRepositoryImpl extends LinearSystemsRepository {
  final Connectivity connectivity;
  final LinearSystemsApi linearSystemsApi;

  LinearSystemsRepositoryImpl(
      {required this.connectivity, required this.linearSystemsApi});
  @override
  Future<Either<Failure, LinearSystemResponse>> solve(
      LinearSystemRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await linearSystemsApi.solve(request);
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
