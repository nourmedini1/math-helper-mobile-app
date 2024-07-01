import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_response.dart';

class TaylorSeriesApi {
  final http.Client client;

  const TaylorSeriesApi({required this.client});

  Future<TaylorSeriesResponse> expand(TaylorSeriesRequest request) async {
    Uri uri = Uri.parse(Endpoints.TAYLOR_SERIES_EXPANSION_ENDPOINT);
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
        TaylorSeriesResponse.fromJson(jsonDecode(response.body)));
  }
}
