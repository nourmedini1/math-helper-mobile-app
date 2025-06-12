import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/components/expandable_widget.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:provider/provider.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'plot_expression_tile.dart';
import 'plot_variation_table_tile.dart';
import 'plot_appearance_tile.dart';
import 'plot_submit_tile.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';

class PlotParametersWidget extends StatefulWidget {
  final bool isFirstPlot;
  final GraphData graphData;
  final TextEditingController functionController;

  const PlotParametersWidget({
    super.key,
    required this.isFirstPlot,
    required this.graphData,
    required this.functionController,
  });

  @override
  State<PlotParametersWidget> createState() => _PlotParametersWidgetState();
}

class _PlotParametersWidgetState extends State<PlotParametersWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context).themeData;
    final isLight = theme == AppThemeData.lightTheme;

    return ExpandableGroup(
      isExpanded: false,
      headerBackgroundColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
      header: _buildHeader(isLight),
      items: [
        PlotExpressionTile(
          isFirstPlot: widget.isFirstPlot,
          isLight: isLight,
          controller: widget.functionController,
        ),
        PlotVariationTableTile(
          isLight: isLight,
          functionController: widget.functionController,
          graphData: widget.graphData,
        ),
        PlotAppearanceTile(
          isLight: isLight,
          isFirstPlot: widget.isFirstPlot,
          graphData: widget.graphData,
        ),
        PlotSubmitTile(
          isLight: isLight,
          isFirstPlot: widget.isFirstPlot,
          functionController: widget.functionController,
        ),
      ],
    );
  }

  Widget _buildHeader(bool isLight) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(Icons.settings,
              color: isLight ? AppColors.customBlack : AppColors.customBlackTint80),
          const SizedBox(width: 8),
          TextFieldLabel(
              label: widget.isFirstPlot ? "First Plot Parameters" : "Second Plot Parameters"),
        ],
      ),
    );
  }
}