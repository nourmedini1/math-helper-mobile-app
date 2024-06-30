import 'package:equatable/equatable.dart';

class ProductRequest extends Equatable {
  final String expression;
  final String variable;
  final Object? lowerLimit;
  final Object? upperLimit;

  const ProductRequest({
    required this.expression,
    required this.variable,
    this.lowerLimit,
    this.upperLimit,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'variable': variable,
      'lowerLimit': lowerLimit,
      'upperLimit': upperLimit,
    };
  }

  @override
  List<Object?> get props => [expression, variable, lowerLimit, upperLimit];
}
