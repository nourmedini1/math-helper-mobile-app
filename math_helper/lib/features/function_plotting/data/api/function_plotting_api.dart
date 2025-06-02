import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:http/http.dart' as http;
import 'package:math_helper/core/api_helpers.dart';
import 'package:math_helper/core/endpoints/endpoints.dart';
import 'package:math_helper/core/messages.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';

class FunctionPlottingApi {
  final http.Client client;
  final ZLibDecoder zlibDecoder;

  const FunctionPlottingApi({required this.client, required this.zlibDecoder});

  Future<PlotResponse> plotFunction(PlotRequest request) async {
    final Uri uri = Uri.parse(Endpoints.PLOT_FUCTION_ENDPOINT);
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
    final responseJson = jsonDecode(response.body);
    responseJson['data'] = unpackData(responseJson['data'] as String);
    return PlotResponse.fromJson(responseJson);
  }

  Map<String, dynamic> unpackData(String compressedBase64) {
    final Uint8List compressedData = base64.decode(compressedBase64);
    final Uint8List packedData = zlibDecoder.decodeBytes(compressedData);
    final dynamic unpacked = deserialize(packedData);
    return (unpacked as Map).map(
      (key, value) => MapEntry(key.toString(), value),
    );
  }
}
