import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
import 'package:meta/meta.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphInitial.initial());

  void updateFirstGraph({
    String? xMin,
    String? xMax,
    String? yMin,
    String? yMax,
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
  }) {
    final currentState = state as GraphInitial;
    final updatedFirst = currentState.firstGraphData.copyWith(
      xMin: xMin,
      xMax: xMax,
      yMin: yMin,
      yMax: yMax,
      function: function,
      xValues: xValues,
      yValues: yValues,
      color: color,
      isVisible: isVisible,
      strokeWidth: strokeWidth,
      dotSize: dotSize,
      showDots: showDots,
      isCurved: isCurved,
      showArea: showArea,
      areaColor: areaColor,
      variationTable: variationTable,
    );
    emit(currentState.copyWith(firstGraphData: updatedFirst));
  }

  void updateSecondGraph({
    String? xMin,
    String? xMax,
    String? yMin,
    String? yMax,
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
  }) {
    final currentState = state as GraphInitial;
    final updatedSecond = currentState.secondGraphData.copyWith(
      xMin: xMin,
      xMax: xMax,
      yMin: yMin,
      yMax: yMax,
      function: function,
      xValues: xValues,
      yValues: yValues,
      color: color,
      isVisible: isVisible,
      strokeWidth: strokeWidth,
      dotSize: dotSize,
      showDots: showDots,
      isCurved: isCurved,
      showArea: showArea,
      areaColor: areaColor,
      variationTable: variationTable,
    );
    emit(currentState.copyWith(secondGraphData: updatedSecond));
  }

  void resetGraphs() {
    emit(GraphInitial.initial());
  }

  GraphData get firstGraphData => (state as GraphInitial).firstGraphData;
  GraphData get secondGraphData => (state as GraphInitial).secondGraphData;
}