import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/variation_table_screen.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
import 'package:provider/provider.dart';

class PlotVariationTableTile extends StatelessWidget {
  final bool isLight;
  final TextEditingController functionController;
  final GraphData graphData;

  const PlotVariationTableTile({
    super.key,
    required this.isLight,
    required this.functionController,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SubmitButton(
            onPressed: () => _onShowVariationTable(context),
            color: AppColors.secondaryColor,
            text: "Show Variation Table",
            icon: Icons.table_chart,
          ),
        ),
      ),
    );
  }

  void _onShowVariationTable(BuildContext context) {
    final functionText = functionController.text.trim();
    final isPeriodic = functionText.contains('sin') || functionText.contains('cos');
    final VariationTable? table = graphData.variationTable;

    if (table != null) {
      if (isPeriodic &&
          table.intervals!.length > 1 &&
          table.values!.length > 1 &&
          table.directions!.length > 1 &&
          table.firstDerivativeSign!.length > 1 &&
          table.secondDerivativeSign!.length > 1) {
        final periodTable = functionText.contains('sin')
            ? sinVariationTable
            : cosVariationTable;
        showVariationTableModal(context, periodTable);
      } else {
        showVariationTableModal(context, table);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No variation table available for this function.")),
      );
    }
  }

  dynamic get sinVariationTable => const VariationTable(
    intervals: [[0, "pi/2"], ["pi/2", 0]],
    values: [[0, 1], [1, 0]],
    directions: ["increasing", "decreasing"],
    firstDerivativeSign: ["+", "-"],
    secondDerivativeSign: ["-", "+"],
  );
  dynamic get cosVariationTable => const VariationTable(
    intervals: [[0, "pi/2"], ["pi/2", 0]],
    values: [[1, 0], [0, -1]],
    directions: ["decreasing", "increasing"],
    firstDerivativeSign: ["-", "+"],
    secondDerivativeSign: ["+", "-"],
  );
  void showVariationTableModal(BuildContext context, VariationTable table) {
  showModalBottomSheet(

    context: context,
    backgroundColor: Provider.of<ThemeManager>(context, listen: false)
        .themeData == AppThemeData.lightTheme
        ? AppColors.customWhite
        : AppColors.customBlackTint20,
        
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16,),
          const TextFieldLabel(label: "Variation Table"),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: CustomPaint(
              painter: VariationTablePainter(table, context),
            ),
          ),
         
        ],
      ),
    ),
  );
}

  
}