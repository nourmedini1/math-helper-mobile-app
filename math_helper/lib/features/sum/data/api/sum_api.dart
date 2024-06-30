import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';

class SumApi {
  final http.Client client;

  const SumApi({required this.client});

  Future<SumResponse> symbolic(SumRequest request) async {
    Uri uri = Uri.parse(Endpoints.SYMBOLIC_SUM_ENDPOINT);
    return await requestSum(uri, request);
  }

  Future<SumResponse> numeric(SumRequest request) async {
    Uri uri = Uri.parse(Endpoints.NUMERICAL_SUM_ENDPOINT);
    return await requestSum(uri, request);
  }

  Future<SumResponse> requestSum(Uri uri, SumRequest request) async {
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
    return Future.value(SumResponse.fromJson(jsonDecode(response.body)));
  }
}
