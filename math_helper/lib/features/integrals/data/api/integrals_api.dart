import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';

class IntegralsApi {
  final http.Client client;

  const IntegralsApi({required this.client});

  Future<IntegralResponse> singlePrimitive(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.SINGLE_PRIMITIVE_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> doublePrimitive(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.DOUBLE_PRIMITIVE_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> triplePrimitive(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.TRIPLE_PRIMITIVE_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> singleIntegral(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.SINGLE_INTEGRAL_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> doubleIntegral(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.DOUBLE_INTEGRAL_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> tripleIntegral(IntegralRequest request) async {
    final Uri uri = Uri.parse(Endpoints.TRIPLE_INTEGRAL_ENDPOINT);
    return await requestIntegral(uri, request);
  }

  Future<IntegralResponse> requestIntegral(
      Uri uri, IntegralRequest request) async {
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
    return Future.value(IntegralResponse.fromJson(jsonDecode(response.body)));
  }
}
