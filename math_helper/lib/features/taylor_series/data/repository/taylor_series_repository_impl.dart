import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/taylor_series/data/api/taylor_series_api.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_response.dart';
import 'package:math_helper/features/taylor_series/domain/repository/taylor_series_repository.dart';

class TaylorSeriesRepositoryImpl extends TaylorSeriesRepository {
  final Connectivity connectivity;
  final TaylorSeriesApi taylorSeriesApi;

  TaylorSeriesRepositoryImpl(
      {required this.connectivity, required this.taylorSeriesApi});

  @override
  Future<Either<Failure, TaylorSeriesResponse>> expand(
      TaylorSeriesRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: connectionUnavailableMessage));
    } else {
      try {
        final response = await taylorSeriesApi.expand(request);
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
