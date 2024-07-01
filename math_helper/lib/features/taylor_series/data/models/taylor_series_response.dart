import 'package:equatable/equatable.dart';

class TaylorSeriesResponse extends Equatable {
  final String expression;
  final String result;

  const TaylorSeriesResponse({required this.expression, required this.result});

  factory TaylorSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TaylorSeriesResponse(
      expression: json['expression'],
      result: json['result'],
    );
  }

  @override
  List<Object?> get props => [expression, result];
}
