import 'package:equatable/equatable.dart';

class IntegralResponse extends Equatable {
  final String integral;
  final String result;

  const IntegralResponse({
    required this.integral,
    required this.result,
  });

  factory IntegralResponse.fromJson(Map<String, dynamic> json) {
    return IntegralResponse(
      integral: json['integral'],
      result: json['result'],
    );
  }

  @override
  List<Object?> get props => [integral, result];
}
