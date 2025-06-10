import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/widgets/symbolic/symbolic_product_initial_screen.dart';
import 'package:math_helper/features/product/presentation/widgets/product_success_screen.dart';

class SymbolicProductScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController lowerBoundController;
  final TextEditingController variableController;
  const SymbolicProductScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.lowerBoundController,
  });

  @override
  State<SymbolicProductScreen> createState() => _SymbolicProductScreenState();
}

class _SymbolicProductScreenState extends State<SymbolicProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SymbolicProductBloc, SymbolicProductState>(
        listener: (context, state) {
          if (state is SymbolicProductFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is SymbolicProductInitial) {
            return SymbolicProductInitialScreen(
              expressionController: widget.expressionController,
              lowerBoundController: widget.lowerBoundController,
              variableController: widget.variableController,
            );
          } else if (state is SymbolicProductLoading) {
            return const LoadingScreen();
          } else if (state is SymbolicProductSuccess) {
            return ProductSuccessScreen(
              isConvergent: state.response.convergent,
              title: "Symbolic Product",
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