import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_success_widget.dart';
import 'package:provider/provider.dart';

class ComplexOperationSuccessScreen extends StatefulWidget {
  final String operation;
  final ComplexOperationsResponse response;
  const ComplexOperationSuccessScreen({super.key, required this.operation, required this.response});

  @override
  State<ComplexOperationSuccessScreen> createState() => _ComplexOperationSuccessScreenState();
}

class _ComplexOperationSuccessScreenState extends State<ComplexOperationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ComplexOperationSuccessWidget(
        title: widget.operation, 
        firstComplexNumberAlgebraicForm: widget.response.z1, 
        secondComplexNumberAlgebraicForm: widget.response.z2, 
        resultComplexNumberAlgebraicForm: widget.response.algebraicResult, 
        firstComplexNumberPolarForm: widget.response.polarZ1, 
        secondComplexNumberPolarForm: widget.response.polarZ2, 
        resultComplexNumberPolarForm: widget.response.polarResult),
        const SizedBox(height: 20),
      ResetButton(
        color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleResetButtonPressed(widget.operation),
        ),
    ]

  );
  }

   void handleResetButtonPressed(String operation) {
    switch (operation) {
      case "Complex Addition":
        BlocProvider.of<ComplexAdditionBloc>(context).add(const ComplexAdditionReset());
        break;
      case "Complex Substraction":
        BlocProvider.of<ComplexSubstractionBloc>(context).add(const ComplexSubstractionReset());
        break;
      case "Complex Multiplication":
        BlocProvider.of<ComplexMultiplicationBloc>(context).add(const ComplexMultiplicationReset());
        break;
    }

}


  
}