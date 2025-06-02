import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_helper/core/errors/exceptions.dart';
import 'package:math_helper/core/messages.dart';

class ApiHelpers {
  ApiHelpers._();
  static const timeoutDuration = Duration(seconds: 40);
  static const headers = {'Content-Type': 'application/json'};

  static void mapStatusCodeToException(http.Response response) {
    if (response.statusCode == 400) {
      if (response.body.toString().contains("violations")) {
        final String message =
            jsonDecode(response.body)['violations'][0]['message'];
        throw ConstraintViolationException(message: message);
      } else {
        print(response.body);
        final String message = jsonDecode(response.body)['detail'];
        throw BadRequestException(message: message);
      }
    } else if (response.statusCode == 500) {
      throw ServerException(message: jsonDecode(response.body)['message']);
    } else if (response.statusCode == 422) {
      const String message = "Invalid input in the request";
      throw BadRequestException(message: message);
    } else {
      print(response.body);
      print(response.statusCode);
      throw UnexpectedException(message: unexpectedErrorMessage);
    }
  }
}
