// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class ComplexOperationSuccessWidget extends StatelessWidget {
  final String title;
  final String firstComplexNumberAlgebraicForm;
  final String secondComplexNumberAlgebraicForm;
  final String resultComplexNumberAlgebraicForm;
  final String firstComplexNumberPolarForm;
  final String secondComplexNumberPolarForm;
  final String resultComplexNumberPolarForm;

  const ComplexOperationSuccessWidget({
    super.key,
    required this.title,
    required this.firstComplexNumberAlgebraicForm,
    required this.secondComplexNumberAlgebraicForm,
    required this.resultComplexNumberAlgebraicForm,
    required this.firstComplexNumberPolarForm,
    required this.secondComplexNumberPolarForm,
    required this.resultComplexNumberPolarForm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context, listen: false).themeData;
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitle(context, theme),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: _buildResultContainer(context, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, ThemeData theme) {
    final isLight = theme == AppThemeData.lightTheme;
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: isLight ? AppColors.primaryColorTint50 : AppColors.primaryColor,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
        ),
      ),
    );
  }

  Widget _buildResultContainer(BuildContext context, ThemeData theme) {
    final isLight = theme == AppThemeData.lightTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: isLight ? AppColors.customBlackTint60 : AppColors.customBlackTint90,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _complexResult(
            context,
            "First complex number",
            firstComplexNumberAlgebraicForm,
            firstComplexNumberPolarForm,
          ),
          _complexResult(
            context,
            "Second complex number",
            secondComplexNumberAlgebraicForm,
            secondComplexNumberPolarForm,
          ),
          _complexResult(
            context,
            "The result",
            resultComplexNumberAlgebraicForm,
            resultComplexNumberPolarForm,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _complexResult(
    BuildContext context,
    String label,
    String algebraicForm,
    String polarForm,
  ) {
    final theme = Provider.of<ThemeManager>(context).themeData;
    final isLight = theme == AppThemeData.lightTheme;
    final labelColor = isLight ? AppColors.customBlack : AppColors.customWhite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _resultLabel(context, label, labelColor),
        _texViewBox(context, algebraicForm, isLight),
        _texViewBox(context, polarForm, isLight, isAlgebraic: false),
      ],
    );
  }

  Widget _resultLabel(BuildContext context, String label, Color color) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 20),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
        ),
      ),
    );
  }

  Widget _texViewBox(BuildContext context, String expression, bool isLight, {bool isAlgebraic = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: TeXView(
        loadingWidgetBuilder: (context) => Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: isLight ? AppColors.primaryColor : AppColors.customBlackTint60,
            ),
          ),
        ),
        child: teXViewWidget(
          context,
          "result",
          r"""$$""" + expression + r"""$$""",
        ),
      ),
    );
  }
}