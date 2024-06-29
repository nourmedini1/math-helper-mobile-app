import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';

class DifferentialEquationsApi {
  final http.Client client;
  const DifferentialEquationsApi({required this.client});

  Future<DifferentialEquationResponse> firstOrder(
      DifferentialEquationRequest request) async {
    Uri uri = Uri.parse(Endpoints.FIRST_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT);
    return await requestDifferentialEquation(uri, request);
  }

  Future<DifferentialEquationResponse> secondOrder(
      DifferentialEquationRequest request) async {
    Uri uri = Uri.parse(Endpoints.SECOND_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT);
    return await requestDifferentialEquation(uri, request);
  }

  Future<DifferentialEquationResponse> thirdOrder(
      DifferentialEquationRequest request) async {
    Uri uri = Uri.parse(Endpoints.THIRD_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT);
    return await requestDifferentialEquation(uri, request);
  }

  Future<DifferentialEquationResponse> requestDifferentialEquation(
      Uri uri, DifferentialEquationRequest request) async {
    final response = await client.post(uri,
        headers: ApiHelpers.headers, body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ApiHelpers.mapStatusCodeToException(response);
    }
    return DifferentialEquationResponse.fromJson(jsonDecode(response.body));
  }
}
