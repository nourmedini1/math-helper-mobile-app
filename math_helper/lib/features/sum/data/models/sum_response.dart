import 'package:equatable/equatable.dart';

class SumResponse extends Equatable {
  final String summation;
  final String result;
  final bool convergent;

  const SumResponse({
    required this.summation,
    required this.result,
    required this.convergent,
  });

  factory SumResponse.fromJson(Map<String, dynamic> json) {
    return SumResponse(
      summation: json['summation'],
      result: json['result'],
      convergent: json['convergent'] ?? false,
    );
  }

  @override
  List<Object?> get props => [summation, result, convergent];
}
