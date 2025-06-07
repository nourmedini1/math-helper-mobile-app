import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class ComplexPolarFormSuccessWidget extends StatelessWidget {
  final String algebraicForm;
  final String polarForm;

  const ComplexPolarFormSuccessWidget({
    super.key,
    required this.algebraicForm,
    required this.polarForm,
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
          const SizedBox(height: 16),
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
        "Polar Form",
        style: TextStyle(
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _complexResult(context, "converted complex number", algebraicForm, polarForm, isLight),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _complexResult(
    BuildContext context,
    String title,
    String algebraicForm,
    String polarForm,
    bool isLight,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _resultLabel(),
        _texViewBox(context, algebraicForm, isLight, showLoading: true),
        _texViewBox(context, polarForm, isLight),
      ],
    );
  }

  Padding _resultLabel() {
    return const Padding(
        padding:  EdgeInsets.only(left: 30, top: 10, bottom: 10),
        child:  TextFieldLabel(label: "Converted complex number"),
      );
  }

  

  Widget _texViewBox(BuildContext context, String expression, bool isLight, {bool showLoading = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: TeXView(
        loadingWidgetBuilder: showLoading
            ? (context) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: isLight ? AppColors.primaryColor : AppColors.customBlackTint60,
                    ),
                  ),
                )
            : null,
        child: teXViewWidget(
          context,
          "result",
          r"""$$""" + expression + r"""$$""",
        ),
      ),
    );
  }
}