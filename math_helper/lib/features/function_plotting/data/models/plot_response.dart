import 'package:equatable/equatable.dart';

class VariationTable extends Equatable {
  final List<List<dynamic>>? intervals;
  final List<List<dynamic>>? values;
  final List<String>? directions;
  final List<String>? firstDerivativeSign;
  final List<String>? secondDerivativeSign;

  const VariationTable({
    required this.intervals,
    required this.values,
    required this.directions,
    required this.firstDerivativeSign,
    required this.secondDerivativeSign,
  });

  Map<String, dynamic> toJson() {
    return {
      'intervals': intervals,
      'values': values,
      'directions': directions,
      'firstDerivativeSign': firstDerivativeSign,
      'secondDerivativeSign': secondDerivativeSign,
    };
  }

  factory VariationTable.fromJson(Map<String, dynamic> json) {
    return VariationTable(
      intervals: (json['intervals'] as List?)
          ?.map<List<dynamic>>((e) => (e as List).toList())
          .toList(),
      values: (json['values'] as List?)
          ?.map<List<dynamic>>((e) => (e as List).toList())
          .toList(),
      directions: (json['directions'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      firstDerivativeSign: (json['firstDerivativeSign'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      secondDerivativeSign: (json['secondDerivativeSign'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        intervals,
        values,
        directions,
        firstDerivativeSign,
        secondDerivativeSign,
      ];
}

class PlotData extends Equatable {
  final List<double> x;
  final List<double> y;

  const PlotData({
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  factory PlotData.fromJson(Map<String, dynamic> json) {
    return PlotData(
      x: (json['x'] as List).map((e) => (e as num).toDouble()).toList(),
      y: (json['y'] as List).map((e) => (e as num).toDouble()).toList(),
    );
  }

  @override
  List<Object?> get props => [x, y];
}

class PlotResponse extends Equatable {
  final PlotData data;
  final int pointsCount;
  final List<List<double>>? criticalPoints;
  final List<List<double>>? inflectionPoints;
  final VariationTable? variationTable;
  final bool isFirstPlot;

  const PlotResponse({
    required this.data,
    required this.pointsCount,
    this.criticalPoints,
    this.inflectionPoints,
    this.variationTable,
    required this.isFirstPlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'pointsCount': pointsCount,
      'criticalPoints': criticalPoints,
      'inflectionPoints': inflectionPoints,
      'variationTable': variationTable?.toJson(),
      'isFirstPlot': isFirstPlot,
    };
  }

  factory PlotResponse.fromJson(Map<String, dynamic> json) {
    return PlotResponse(
      isFirstPlot: json['isFirstPlot'] as bool? ?? true,
      data: PlotData.fromJson(json['data'] as Map<String, dynamic>),
      pointsCount: json['pointsCount'] as int,
      criticalPoints: (json['criticalPoints'] as List?)
          ?.map<List<double>>((e) => (e as List).map((i) => (i as num).toDouble()).toList())
          .toList(),
      inflectionPoints: (json['inflectionPoints'] as List?)
          ?.map<List<double>>((e) => (e as List).map((i) => (i as num).toDouble()).toList())
          .toList(),
      variationTable: json['variationTable'] != null
          ? VariationTable.fromJson(json['variationTable'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        data,
        pointsCount,
        criticalPoints,
        inflectionPoints,
        variationTable,
        isFirstPlot,
      ];
}
