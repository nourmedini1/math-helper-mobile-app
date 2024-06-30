import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';

class LimitsApi {
  final http.Client client;

  const LimitsApi({required this.client});

  Future<LimitResponse> single(LimitRequest request) async {
    Uri uri = Uri.parse(Endpoints.SINGLE_LIMIT_ENDPOINT);
    return await requestLimit(uri, request);
  }

  Future<LimitResponse> double(LimitRequest request) async {
    Uri uri = Uri.parse(Endpoints.DOUBLE_LIMIT_ENDPOINT);
    return await requestLimit(uri, request);
  }

  Future<LimitResponse> triple(LimitRequest request) async {
    Uri uri = Uri.parse(Endpoints.TRIPLE_LIMIT_ENDPOINT);
    return await requestLimit(uri, request);
  }

  Future<LimitResponse> requestLimit(Uri uri, LimitRequest request) async {
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
    return Future.value(LimitResponse.fromJson(jsonDecode(response.body)));
  }
}
