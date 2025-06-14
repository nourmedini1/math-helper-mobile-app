import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class LinearSystemSuccessWidget extends StatelessWidget {
  final String title;
  final String linearSystem;
  final String result;

  const LinearSystemSuccessWidget({
    super.key,
    required this.title,
    required this.linearSystem,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                title,
                style: TextStyle(
                  color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.primaryColorTint50
                      : AppColors.primaryColor,
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint60
                      : AppColors.customBlackTint90,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: _LinearSystemResultSection(
                linearSystem: linearSystem,
                result: result,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinearSystemResultSection extends StatelessWidget {
  final String linearSystem;
  final String result;

  const _LinearSystemResultSection({
    required this.linearSystem,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context, listen: false).themeData;
    Color loaderColor = theme == AppThemeData.lightTheme
        ? AppColors.primaryColor
        : AppColors.customBlackTint60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 10, top: 20),
          child: TextFieldLabel(label: "The Linear System"),
        ),
        _LinearSystemTeXView(value: linearSystem, loaderColor: loaderColor, padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20)),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: TextFieldLabel(label: "The result")
          ),
        ),
        _LinearSystemTeXView(value: result, loaderColor: loaderColor, padding: const EdgeInsets.only(left: 10, right: 10)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _LinearSystemTeXView extends StatelessWidget {
  final String value;
  final Color loaderColor;
  final EdgeInsets padding;

  const _LinearSystemTeXView({
    required this.value,
    required this.loaderColor,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TeXView(
        style: const TeXViewStyle(textAlign: TeXViewTextAlign.left),
        loadingWidgetBuilder: (context) => Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: loaderColor),
        ),
        child: teXViewWidget(context, "result", r"$$" + value + r"$$"),
      ),
    );
  }
}