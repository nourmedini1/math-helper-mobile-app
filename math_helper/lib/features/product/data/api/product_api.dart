import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/data/models/product_response.dart';

class ProductApi {
  final http.Client client;

  const ProductApi({required this.client});

  Future<ProductResponse> symbolic(ProductRequest request) async {
    Uri uri = Uri.parse(Endpoints.SYMBOLIC_PRODUCT_ENDPOINT);
    return await requestProduct(uri, request);
  }

  Future<ProductResponse> numeric(ProductRequest request) async {
    Uri uri = Uri.parse(Endpoints.NUMERICAL_PRODUCT_ENDPOINT);
    return await requestProduct(uri, request);
  }

  Future<ProductResponse> requestProduct(
      Uri uri, ProductRequest request) async {
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
    return Future.value(ProductResponse.fromJson(jsonDecode(response.body)));
  }
}
