import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class TaylorSeriesSuccessWidget extends StatelessWidget {
  final String title;
  final String expression;
  final String result;

  const TaylorSeriesSuccessWidget({
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: TextStyle(
            color: Provider.of<ThemeManager>(context).themeData == AppThemeData.lightTheme
                ? AppColors.primaryColorTint50
                : AppColors.primaryColor,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            fontFamily: Theme.of(context).textTheme.titleMedium?.fontFamily,
          ),
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
        child: _TaylorSeriesResult(
          expression: expression,
          result: result,
        ),
      ),
    );
  }
}

class _TaylorSeriesResult extends StatelessWidget {
  final String expression;
  final String result;

  const _TaylorSeriesResult({
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context).themeData;
    final isLight = theme == AppThemeData.lightTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 30, top: 20, bottom: 8),
            child: TextFieldLabel(label: "The expansion result")
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: TeXView(
            loadingWidgetBuilder: (context) => Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: isLight
                      ? AppColors.primaryColor
                      : AppColors.customBlackTint60,
                ),
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
          padding: const EdgeInsets.only(left: 20, right: 10),
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