import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_response.dart';

class LinearSystemsApi {
  final http.Client client;

  const LinearSystemsApi({required this.client});

  Future<LinearSystemResponse> solve(LinearSystemRequest request) async {
    Uri uri = Uri.parse(Endpoints.LINEAR_SYSTEMS_ENDPOINT);
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
    return Future.value(
        LinearSystemResponse.fromJson(jsonDecode(response.body)));
  }
}
