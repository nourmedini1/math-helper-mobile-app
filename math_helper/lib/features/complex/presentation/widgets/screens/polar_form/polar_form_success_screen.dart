import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/models/polar_form_response.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/polar_form/polar_form_success_widget.dart';
import 'package:provider/provider.dart';

class PolarFormSuccessScreen extends StatefulWidget {
  final PolarFormResponse response;
  const PolarFormSuccessScreen({super.key, required this.response});

  @override
  State<PolarFormSuccessScreen> createState() => _PolarFormSuccessScreenState();
}

class _PolarFormSuccessScreenState extends State<PolarFormSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ComplexPolarFormSuccessWidget(
        algebraicForm: widget.response.algebraicForm, 
        polarForm: widget.response.polarForm, 
       ),
        const SizedBox(height: 20),
      ResetButton(
        color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleResetButtonPressed(),
        ),
    ]

  );
  }

   void handleResetButtonPressed() {
      BlocProvider.of<PolarFormBloc>(context).add(const PolarFormReset());
    }
}