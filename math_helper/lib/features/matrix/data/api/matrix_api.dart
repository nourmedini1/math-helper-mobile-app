import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';

class MatrixApi {
  final http.Client client;

  const MatrixApi({required this.client});

  Future<MatrixResponse> add(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.ADD_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> multiply(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.MULTIPLY_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> invert(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.INVERT_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> rank(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.RANK_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> determinant(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.DETERMINANT_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> eigen(MatrixRequest request) async {
    return await requestMatrixOperation(
      Uri.parse(Endpoints.EIGEN_MATRIX_ENDPOINT),
      request,
    );
  }

  Future<MatrixResponse> requestMatrixOperation(
      Uri uri, MatrixRequest request) async {
    final response = await client
        .post(
      uri,
      headers: ApiHelpers.headers,
      body: jsonEncode(request.toJson()),
    )
        .timeout(
      ApiHelpers.timeoutDuration,
      onTimeout: () {
        throw TimeoutException(timeoutMessage);
      },
    );
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return Future.value(MatrixResponse.fromJson(jsonDecode(response.body)));
  }
}
