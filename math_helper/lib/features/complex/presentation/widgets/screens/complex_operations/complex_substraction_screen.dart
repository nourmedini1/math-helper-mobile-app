import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_initial_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_success_screen.dart';

class ComplexSubstractionScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  const ComplexSubstractionScreen({super.key, required this.controllers});

  @override
  State<ComplexSubstractionScreen> createState() => _ComplexSubstractionScreenState();
}

class _ComplexSubstractionScreenState extends State<ComplexSubstractionScreen> {
  @override
  Widget build(BuildContext context) {
    const  String operation = "Complex Substraction";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ComplexSubstractionBloc, ComplexSubstractionState>(
        listener: (context, state) {
          if (state is ComplexSubstractionFailure) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ComplexSubstractionInitial) {
            return ComplexOperationInitialScreen(controllers: widget.controllers, operation: operation);
          } else if (state is ComplexSubstractionLoading) {
            return const LoadingScreen();
          } else if (state is ComplexSubstractionSuccess) {
            return ComplexOperationSuccessScreen(operation: operation, response: state.response);
          } else if (state is ComplexSubstractionFailure) {
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