import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/custom_graph.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';

class GraphWidget extends StatelessWidget {
  final GraphData firstGraphData;
  final GraphData secondGraphData;
  const GraphWidget({
    super.key,
    required this.firstGraphData,
    required this.secondGraphData,
    });

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Center(
          child: CustomGraph(
  x1: firstGraphData.xValues,
  y1: firstGraphData.yValues,
  x2: secondGraphData.xValues,
  y2: secondGraphData.yValues,
  showFirst: firstGraphData.isVisible,
  showSecond: secondGraphData.isVisible,
  color1: firstGraphData.color,
  color2: secondGraphData.color,
  strokeWidth1: firstGraphData.strokeWidth,
  strokeWidth2: secondGraphData.strokeWidth,
  showDots1: firstGraphData.showDots,
  showDots2: secondGraphData.showDots,
  showArea1: firstGraphData.showArea,
  showArea2: secondGraphData.showArea,
  areaColor1: firstGraphData.areaColor ?? AppColors.primaryColorShade20.withOpacity(0.2),
  areaColor2: secondGraphData.areaColor ?? AppColors.secondaryColorShade20.withOpacity(0.2),
  xMin: double.parse(firstGraphData.xMin),
  xMax: double.parse(firstGraphData.xMax),
  yMin: double.parse(firstGraphData.yMin),
  yMax: double.parse(firstGraphData.yMax),
  functionName1: firstGraphData.function,
  functionName2: secondGraphData.function,
)
        ),
      ),
    );
  }
  }
