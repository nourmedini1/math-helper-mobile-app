import 'package:equatable/equatable.dart';

class DerivativeRequest extends Equatable {
  final String expression;
  final String variable;
  final bool partial;
  final int order;
  final String? derivingPoint;

  const DerivativeRequest({
    required this.expression,
    required this.variable,
    required this.partial,
    required this.order,
    this.derivingPoint,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'variable': variable,
      'partial': partial,
      'order': order,
      'derivingPoint': derivingPoint,
    };
  }

  @override
  List<Object?> get props =>
      [expression, variable, partial, order, derivingPoint];
}
