import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class SumSuccessWidget extends StatelessWidget {
  final String title;
  final String expression;
  final String result;
  final bool isConvergent;

  const SumSuccessWidget({
    super.key,
    required this.title,
    required this.expression,
    required this.result,
    required this.isConvergent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context, listen: false).themeData;
    final isLight = theme == AppThemeData.lightTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildTitle(context),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: _buildResultContainer(context, isLight),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Provider.of<ThemeManager>(context).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.primaryColorTint50
              : AppColors.primaryColor,
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          fontFamily: Theme.of(context).textTheme.titleMedium?.fontFamily,
        ),
      ),
    );
  }

  Widget _buildResultContainer(BuildContext context, bool isLight) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: isLight ? AppColors.customBlackTint60 : AppColors.customBlackTint90,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _SumResult(
          expression: expression,
          result: result,
          isConvergent: isConvergent,
        ),
      ),
    );
  }
}

class _SumResult extends StatelessWidget {
  final String expression;
  final String result;
  final bool isConvergent;

  const _SumResult({
    required this.expression,
    required this.result,
    required this.isConvergent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context).themeData;
    final isLight = theme == AppThemeData.lightTheme;
    final labelColor = isLight ? AppColors.customBlack : AppColors.customWhite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              "The Sum result",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: labelColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TeXView(
            style: const TeXViewStyle(textAlign: TeXViewTextAlign.left),
            loadingWidgetBuilder: (context) => Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: isLight
                    ? AppColors.primaryColor
                    : AppColors.customBlackTint60,
              ),
            ),
            child: teXViewWidget(
              context,
              "result",
              r"""$$""" + expression + r"""$$""",
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TeXView(
            child: teXViewWidget(
              context,
              "result",
              !isConvergent ? r"""$$\text{The sum is divergent}$$""" : r"""$$""" + result + r"""$$""",
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}