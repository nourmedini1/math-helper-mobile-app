import 'package:equatable/equatable.dart';

class DerivativeResponse extends Equatable {
  final Object result;
  final String derivative;

  const DerivativeResponse({
    required this.result,
    required this.derivative,
  });

  factory DerivativeResponse.fromJson(Map<String, dynamic> json) {
    return DerivativeResponse(
      result: json['result'],
      derivative: json['derivative'],
    );
  }

  @override
  List<Object?> get props => [result, derivative];
}
