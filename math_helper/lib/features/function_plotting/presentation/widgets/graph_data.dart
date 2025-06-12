import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';

class GraphData extends Equatable {
  final String xMin;
  final String xMax;
  final String yMin;
  final String yMax;
  final String function;
  final List<double> xValues;
  final List<double> yValues;
  final Color color;
  final bool isVisible;
  final double strokeWidth;
  final double dotSize;
  final bool showDots;
  final bool isCurved;
  final bool showArea;
  final Color? areaColor;
  final VariationTable? variationTable;

  const GraphData({
    required this.function,
    required this.xValues,
    required this.yValues,
    this.color = AppColors.primaryColorShade40,
    this.isVisible = true,
    this.strokeWidth = 3.0,
    this.dotSize = 4.0,
    this.showDots = false,
    this.isCurved = true,
    this.showArea = false,
    this.areaColor = AppColors.primaryColorShade20,
    this.variationTable,
    this.xMin = '-10',
    this.xMax = '10',
    this.yMin = '-2',
    this.yMax = '2',
  });

  factory GraphData.initialiseWithSin() {
    return GraphData(
      function: 'sin(x)',
      xValues: List.generate(100, (i) => -10 + i * 20 / 99),
      yValues: List.generate(100, (i) => sin(-10 + i * 20 / 99)),
      color: AppColors.primaryColor,
      isVisible: true,
      areaColor: AppColors.primaryColorShade20.withOpacity(0.2),
      variationTable: const VariationTable(
        intervals: [[0, "pi/2"], ["pi/2", 0]],
        values: [[0, 1], [1, 0]],
        directions: ["increasing", "decreasing"],
        firstDerivativeSign: ["+", "-"],
        secondDerivativeSign: ["-", "+"],
      ),
    );
  }

  factory GraphData.initialiseWithCos() {
    return GraphData(
      function: 'cos(x)',
      xValues: List.generate(100, (i) => -10 + i * 20 / 99),
      yValues: List.generate(100, (i) => cos(-10 + i * 20 / 99)),
      color: AppColors.secondaryColorShade20,
      isVisible: false,
      strokeWidth: 3.0,
      dotSize: 4.0,
      areaColor: AppColors.secondaryColorShade20.withOpacity(0.2),
      variationTable: const VariationTable(
        intervals: [[0, "pi/2"], ["pi/2", 0]],
        values: [[0, 1], [1, 0]],
        directions: ["decreasing", "increasing"],
        firstDerivativeSign: ["-", "+"],
        secondDerivativeSign: ["+", "-"],
      ),
    );
  }

  GraphData copyWith({
    String? function,
    List<double>? xValues,
    List<double>? yValues,
    Color? color,
    bool? isVisible,
    double? strokeWidth,
    double? dotSize,
    bool? showDots,
    bool? isCurved,
    bool? showArea,
    Color? areaColor,
    VariationTable? variationTable,
    String? xMin,
    String? xMax,
    String? yMin,
    String? yMax,
  }) {
    return GraphData(
      xMin: xMin ?? this.xMin,
      xMax: xMax ?? this.xMax,
      yMin: yMin ?? this.yMin,
      yMax: yMax ?? this.yMax,
      function: function ?? this.function,
      xValues: xValues ?? this.xValues,
      yValues: yValues ?? this.yValues,
      color: color ?? this.color,
      isVisible: isVisible ?? this.isVisible,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dotSize: dotSize ?? this.dotSize,
      showDots: showDots ?? this.showDots,
      isCurved: isCurved ?? this.isCurved,
      showArea: showArea ?? this.showArea,
      areaColor: areaColor ?? this.areaColor,
      variationTable: variationTable ?? this.variationTable,
    );
  }

  @override
  List<Object?> get props => [
        function,
        xValues,
        yValues,
        color,
        isVisible,
        strokeWidth,
        dotSize,
        showDots,
        isCurved,
        showArea,
        areaColor,
        variationTable,
        xMin,
        xMax,
        yMin,
        yMax,
      ];
}