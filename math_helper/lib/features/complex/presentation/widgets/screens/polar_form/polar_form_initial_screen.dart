import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/complex_number_textfields_groupement.dart';
import 'package:math_helper/features/complex/presentation/cubit/polar_form_cubit/polar_form_cubit.dart';
import 'package:provider/provider.dart';

class PolarFormInitialScreen extends StatefulWidget {
  final TextEditingController realController;
  final TextEditingController imaginaryController;
  const PolarFormInitialScreen({super.key, 
    required this.realController, 
    required this.imaginaryController});

  @override
  State<PolarFormInitialScreen> createState() => _PolarFormInitialScreenState();
}

class _PolarFormInitialScreenState extends State<PolarFormInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Polar Form", 
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComplexNumberTextFieldsGroupement(
            label: "The complex number", 
            realNumberHintText: "Enter the real component",
            imaginaryNumberHintText: "Enter the imaginary component", 
            realController: widget.realController, 
            imaginaryController: widget.imaginaryController, 
            onChanged: (value) => handleInputChange(
              [widget.realController, widget.imaginaryController])),
        ],
      ),
      submitButton: BlocBuilder<PolarFormCubit, PolarFormCubitState>(
        builder: (context, state) {
          if (state is PolarFormFieldsMissing) {
            return SubmitButton(
              color : AppColors.customBlackTint60,
              onPressed: () {},
            );
          } else if (state is PolarFormFieldsReady) {
            return SubmitButton(
              color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.primaryColor,
              onPressed: () => handleSubmitButtonPressed(
                context, 
                widget.realController, 
                widget.imaginaryController),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      clearButton: ClearButton(
        onPressed: () => handleClearButtonPressed(
          widget.realController, 
          widget.imaginaryController),
      ),
      );
  }

   
void handleSubmitButtonPressed(
    BuildContext context,  TextEditingController realController, TextEditingController imaginaryController ) {
  final request = PolarFormRequest(
    real: realController.text,
    imaginary: imaginaryController.text,
  );
  BlocProvider.of<PolarFormBloc>(context).add(PolarFormRequested(request: request));
}

void handleClearButtonPressed(TextEditingController realController, TextEditingController imaginaryController) {
  realController.clear();
  imaginaryController.clear();
  context.read<PolarFormCubit>().checkFieldsReady(false);
}

 void handleInputChange(List<TextEditingController> controllers) {
  final allFilled = controllers.every((c) => c.text.isNotEmpty);
  context.read<PolarFormCubit>().checkFieldsReady(allFilled);
}

}