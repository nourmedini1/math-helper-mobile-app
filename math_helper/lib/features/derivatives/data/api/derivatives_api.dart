import 'dart:async';
import 'dart:convert';

import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:http/http.dart' as http;

class DerivativesApi {
  final http.Client client;
  const DerivativesApi({required this.client});

  Future<DerivativeResponse> symbolicDerivative(
      DerivativeRequest request) async {
    Uri uri = Uri.parse(Endpoints.SYMBOLIC_DERIVATIVE_ENDPOINT);
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
    return Future.value(DerivativeResponse.fromJson(jsonDecode(response.body)));
  }

  Future<DerivativeResponse> numericDerivative(
      DerivativeRequest request) async {
    Uri uri = Uri.parse(Endpoints.NUMERICAL_DERIVATIVE_ENDPOINT);
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
    return Future.value(DerivativeResponse.fromJson(jsonDecode(response.body)));
  }
}
