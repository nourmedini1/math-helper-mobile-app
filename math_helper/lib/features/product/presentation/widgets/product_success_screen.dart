import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/widgets/product_success_widget.dart';
import 'package:provider/provider.dart';

class ProductSuccessScreen extends StatelessWidget {
   final String title;
  final String product;
  final String result;
  final bool isConvergent;
  const ProductSuccessScreen({
    super.key,
    required this.title,
    required this.product,
    required this.result,
    required this.isConvergent,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ProductSuccessWidget(
        isConvergent: isConvergent,
        title: title, 
        expression: product, 
        result: result),
      const SizedBox(height: 20),
      ResetButton(
        color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleResetButtonPressed(context),
        ),
    ],

    );
  }

  void handleResetButtonPressed(BuildContext context) {
    switch (title) {
      case "Symbolic Product":
        context.read<SymbolicProductBloc>().add(const SymbolicProductReset());
        break;
      case "Numeric Product":
        context.read<NumericProductBloc>().add(const NumericProductReset());
        break;   
      default:
        throw Exception("Unknown product type: $title");
    }
  }
    
      
}