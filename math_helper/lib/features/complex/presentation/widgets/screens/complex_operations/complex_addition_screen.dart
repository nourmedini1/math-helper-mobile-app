import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_initial_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_success_screen.dart';

class ComplexAdditionScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  const ComplexAdditionScreen({super.key, required this.controllers});

  @override
  State<ComplexAdditionScreen> createState() => _ComplexAdditionScreenState();
}

class _ComplexAdditionScreenState extends State<ComplexAdditionScreen> {
  @override
  Widget build(BuildContext context) {
    const  String operation = "Complex Addition";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ComplexAdditionBloc, ComplexAdditionState>(
        listener: (context, state) {
          if (state is ComplexAdditionFailure) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ComplexAdditionInitial) {
            return ComplexOperationInitialScreen(controllers: widget.controllers, operation: operation);
          } else if (state is ComplexAdditionLoading) {
            return const LoadingScreen();
          } else if (state is ComplexAdditionSuccess) {
            return ComplexOperationSuccessScreen(operation: operation, response: state.response);
          } else if (state is ComplexAdditionFailure) {
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

