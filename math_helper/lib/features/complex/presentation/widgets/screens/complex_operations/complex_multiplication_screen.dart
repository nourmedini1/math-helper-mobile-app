import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_initial_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_success_screen.dart';

class ComplexMultiplicationScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  const ComplexMultiplicationScreen({super.key, required this.controllers});

  @override
  State<ComplexMultiplicationScreen> createState() => _ComplexMultiplicationScreenState();
}

class _ComplexMultiplicationScreenState extends State<ComplexMultiplicationScreen> {
  @override
  Widget build(BuildContext context) {
    const  String operation = "Complex Multiplication";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ComplexMultiplicationBloc, ComplexMultiplicationState>(
        listener: (context, state) {
          if (state is ComplexMultiplicationFailure) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ComplexMultiplicationInitial) {
            return ComplexOperationInitialScreen(controllers: widget.controllers, operation: operation);
          } else if (state is ComplexMultiplicationLoading) {
            return const LoadingScreen();
          } else if (state is ComplexMultiplicationSuccess) {
            return ComplexOperationSuccessScreen(operation: operation, response: state.response);
          } else if (state is ComplexMultiplicationFailure) {
            return ComplexOperationInitialScreen(controllers: widget.controllers, operation: operation);
          }
          return Container();
        },
      ),
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