import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/widgets/numeric/numeric_product_initial_screen.dart';
import 'package:math_helper/features/product/presentation/widgets/product_success_screen.dart';

class NumericProductScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final TextEditingController variableController;
  const NumericProductScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.boundControllers,
  });

  @override
  State<NumericProductScreen> createState() => _NumericProductScreenState();
}

class _NumericProductScreenState extends State<NumericProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<NumericProductBloc, NumericProductState>(
        listener: (context, state) {
          if (state is NumericProductFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is NumericProductInitial) {
            return NumericProductInitialScreen(
              expressionController: widget.expressionController,
              boundControllers: widget.boundControllers,
              variableController: widget.variableController,
            );
          } else if (state is NumericProductLoading) {
            return const LoadingScreen();
          } else if (state is NumericProductSuccess) {
            return ProductSuccessScreen(
              isConvergent: state.response.convergent,
              title: "Numeric Product",
              product: state.response.product,
              result: state.response.result,
            );
          }
          return const SizedBox.shrink();
        },
      )
      
    );
  }

  void showToast(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.customRed,
      ),
    );
  }
}