import 'package:equatable/equatable.dart';

class PlotRequest extends Equatable {
  final String function;
  final int precision;
  final double lowerBound;
  final double upperBound;
  final int maxPoints;
  final bool isFirstPlot;

  const PlotRequest({
    required this.function,
    required this.precision,
    required this.lowerBound,
    required this.upperBound,
    required this.maxPoints,
    required this.isFirstPlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'isFirstPlot': isFirstPlot,
      'function': function,
      'precision': precision,
      'lowerBound': lowerBound,
      'upperBound': upperBound,
      'maxPoints': maxPoints,
    };
  }

  @override
  List<Object?> get props =>
      [function, precision, lowerBound, upperBound, maxPoints, isFirstPlot];
}
