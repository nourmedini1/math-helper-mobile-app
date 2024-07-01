import 'package:equatable/equatable.dart';

class TaylorSeriesRequest extends Equatable {
  final String expression;
  final String variable;
  final Object? near;
  final int? order;

  const TaylorSeriesRequest({
    required this.expression,
    required this.variable,
    this.near,
    this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'variable': variable,
      'near': near,
      'order': order,
    };
  }

  @override
  List<Object?> get props => [expression, variable, near, order];
}
