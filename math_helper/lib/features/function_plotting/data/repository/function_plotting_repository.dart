import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/errors/failure.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/function_plotting/data/api/function_plotting_api.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/domain/repository/function_plotting_repository.dart';

class FunctionPlottingRepositoryImpl extends FunctionPlottingRepository {
  final Connectivity connectivity;
  final FunctionPlottingApi functionPlottingApi;

  FunctionPlottingRepositoryImpl({
    required this.connectivity,
    required this.functionPlottingApi,
  });

  @override
  Future<Either<Failure, PlotResponse>> plotFunction(
      PlotRequest request) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(ConnectionUnavailableFailure(
          failureMessage: 'No internet connection available.'));
    } else {
      try {
        final response = await functionPlottingApi.plotFunction(request);
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
