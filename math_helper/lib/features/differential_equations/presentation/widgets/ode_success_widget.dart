import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class OdeSuccessWidget extends StatelessWidget {
   final String title;
  final String expression;
  final String result;
  const OdeSuccessWidget({
    super.key,
    required this.title,
    required this.expression,
    required this.result,
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
          color: AppColors.primaryColorTint50,
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
        child: _OdeResult(
          expression: expression,
          result: result,
        ),
      ),
    );
  }
}

class _OdeResult extends StatelessWidget {
  final String expression;
  final String result;

  const _OdeResult({
    required this.expression,
    required this.result,
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
              "The Ode result",
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
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TeXView(
            child: teXViewWidget(
              context,
              "result",
              r"""$$""" + result + r"""$$""",
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}