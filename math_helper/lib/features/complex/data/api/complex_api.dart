import 'dart:async';
import 'dart:convert';

import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:http/http.dart' as http;
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/data/models/polar_form_response.dart';

class ComplexApi {
  final http.Client client;

  const ComplexApi({required this.client});

  Future<ComplexOperationsResponse> addition(
      ComplexOperationsRequest request) async {
    Uri uri = Uri.parse(Endpoints.ADDITION_ENDPOINT);
    final response = await client
        .post(uri,
            headers: ApiHelpers.headers, body: jsonEncode(request.toJson()))
        .timeout(
      ApiHelpers.timeoutDuration,
      onTimeout: () {
        throw TimeoutException(timeoutMessage);
      },
    );
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return Future.value(
        ComplexOperationsResponse.fromJson(jsonDecode(response.body)));
  }

  Future<ComplexOperationsResponse> multiplication(
      ComplexOperationsRequest request) async {
    Uri uri = Uri.parse(Endpoints.MULTIPLICATION_ENDPOINT);
    final response = await client
        .post(uri,
            headers: ApiHelpers.headers, body: jsonEncode(request.toJson()))
        .timeout(
      ApiHelpers.timeoutDuration,
      onTimeout: () {
        throw TimeoutException(timeoutMessage);
      },
    );
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return Future.value(
        ComplexOperationsResponse.fromJson(jsonDecode(response.body)));
  }

  Future<ComplexOperationsResponse> substraction(
      ComplexOperationsRequest request) async {
    Uri uri = Uri.parse(Endpoints.SUBSTRACTION_ENDPOINT);
    final response = await client
        .post(uri,
            headers: ApiHelpers.headers, body: jsonEncode(request.toJson()))
        .timeout(
      ApiHelpers.timeoutDuration,
      onTimeout: () {
        throw TimeoutException(timeoutMessage);
      },
    );
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return Future.value(
        ComplexOperationsResponse.fromJson(jsonDecode(response.body)));
  }

  Future<PolarFormResponse> getPolarForm(PolarFormRequest request) async {
    Uri uri = Uri.parse(Endpoints.POLAR_FORM_ENDPOINT);
    final response = await client
        .post(uri,
            headers: ApiHelpers.headers, body: jsonEncode(request.toJson()))
        .timeout(
      ApiHelpers.timeoutDuration,
      onTimeout: () {
        throw TimeoutException(timeoutMessage);
      },
    );
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return Future.value(PolarFormResponse.fromJson(jsonDecode(response.body)));
  }
}
