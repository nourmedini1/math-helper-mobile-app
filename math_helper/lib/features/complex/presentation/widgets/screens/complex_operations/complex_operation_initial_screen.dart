import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/cubit/addition_cubit/addition_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/multiplication_cubit/multiplication_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/substraction_cubit/substraction_cubit.dart';
import 'package:math_helper/features/complex/presentation/widgets/buttons/complex_operation_submit_button.dart';
import 'package:math_helper/features/complex/presentation/widgets/complex_number_textfields_groupement.dart';

class ComplexOperationInitialScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final String operation;
  const ComplexOperationInitialScreen({super.key, required this.controllers, required this.operation});

  @override
  State<ComplexOperationInitialScreen> createState() => _ComplexOperationInitialScreenState();
}

class _ComplexOperationInitialScreenState extends State<ComplexOperationInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: widget.operation, 
      body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComplexNumberTextFieldsGroupement(
                  label: 'First complex number',
                  realNumberHintText: 'Enter the real component',
                  imaginaryNumberHintText: 'Enter the imaginary component',
                  realController: widget.controllers[0],
                  imaginaryController: widget.controllers[1],
                  onChanged: (value) => handleInputChange(
                      widget.controllers, widget.operation)),
             
              ComplexNumberTextFieldsGroupement(
                label: 'Second complex number',
                realNumberHintText: 'Enter the real component',
                imaginaryNumberHintText: 'Enter the imaginary component',
                realController: widget.controllers[2],
                imaginaryController: widget.controllers[3],
                onChanged: (value) => handleInputChange(
                    widget.controllers, widget.operation)),
            ],
          ), 
      submitButton: ComplexOperationSubmitButton(
        operation: widget.operation,
        controllers: widget.controllers,
        onSubmitButtonPressed: () => handleSubmitButtonPressed(
          context, 
          widget.operation, 
          widget.controllers
        ), 
      ),
      clearButton: ClearButton(
        onPressed: () => handleClearButtonPressed(
          widget.controllers, 
          widget.operation
        ),
      ),
    );
  }

  

 
void handleSubmitButtonPressed(
    BuildContext context, String operation, List<TextEditingController> controllers) {
  final request = ComplexOperationsRequest(
    real1: controllers[0].text,
    real2: controllers[1].text,
    imaginary1: controllers[2].text,
    imaginary2: controllers[3].text,
  );

  final eventDispatchers = {
    "Complex Addition": () => BlocProvider.of<ComplexAdditionBloc>(context)
        .add(ComplexAdditionRequested(request: request)),
    "Complex Substraction": () => BlocProvider.of<ComplexSubstractionBloc>(context)
        .add(ComplexSubstractionRequested(request: request)),
    "Complex Multiplication": () => BlocProvider.of<ComplexMultiplicationBloc>(context)
        .add(ComplexMultiplicationRequested(request: request)),
  };

  eventDispatchers[operation]?.call();
}

void handleClearButtonPressed(List<TextEditingController> controllers, String operation) {
  
  for (var controller in controllers) {
    controller.clear();
  }
  switch (operation) {
    case "Complex Addition":
      context.read<AdditionCubit>().checkFieldsReady(false);
      break;
    case "Complex Substraction":
      context.read<SubstractionCubit>().checkFieldsReady(false);
      break;
    case "Complex Multiplication":
      context.read<MultiplicationCubit>().checkFieldsReady(false);
      break;
  }
}

 void handleInputChange(List<TextEditingController> controllers, String operation) {
  final allFilled = controllers.every((c) => c.text.isNotEmpty);
  setState(() {
    switch (operation) {
      case "Complex Addition":
        context.read<AdditionCubit>().checkFieldsReady(allFilled);
        break;
      case "Complex Substraction":
        context.read<SubstractionCubit>().checkFieldsReady(allFilled);
        break;
      case "Complex Multiplication":
        context.read<MultiplicationCubit>().checkFieldsReady(allFilled);
        break;
    }
  });
}


}