import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/mathematical_topic.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/pages/about_page.dart';
import 'package:provider/provider.dart';

class MathematicalTopicsGroupWidget extends StatelessWidget {
  const MathematicalTopicsGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mathTopicExpander(
                    context,
                    "Integrals",
                    "Integrals measure the area under curves up to 3 dimensions",
                    Image.asset(
                      CustomIcons.integral,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? null
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Definite integrals",
                          "Definite integrals measure the surface under a curve for a given interval",
                          SvgPicture.asset(
                            CustomIcons.singlePrimitive,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Indefinite Integrals",
                          "Determines the primitive's expression of a given function",
                          SvgPicture.asset(
                            CustomIcons.definiteIntegral,
                            width: 15,
                            height: 20,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {})
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Differential Calculus",
                    "Differential calculus studies the variation of a mathematical function",
                    Image.asset(
                      CustomIcons.differentialCalculus,
                      width: 57,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Derivatives",
                          "Provides the expression of the function variation or its value in a given point",
                          Image.asset(
                            CustomIcons.derivative,
                            width: 25,
                            height: 30,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Differential Equations",
                          "Deals with the very small variation in mathematical function up to 3 orders",
                          Image.asset(
                            CustomIcons.differentialEquation,
                            width: 25,
                            height: 50,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {})
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Complex Analysis",
                    "Complex numbers have many applications in math and physics",
                    Image.asset(
                      CustomIcons.complexAnalysis,
                      width: 57,
                      height: 70,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Complex Operations",
                          "Functionalities to add, substract and multiply complex numbers",
                          Image.asset(
                            CustomIcons.operations,
                            width: 25,
                            height: 30,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Polar Form",
                          "Provides the polar form of a given complex number",
                          Image.asset(
                            CustomIcons.polarForm,
                            width: 25,
                            height: 50,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {})
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Numerical Series",
                    "Handles sums and products of series as well as taylor expansion",
                    Image.asset(
                      CustomIcons.binomial,
                      width: 57,
                      height: 100,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Summations",
                          "Evaluates the convergence of series of summation of a given expression",
                          Image.asset(
                            CustomIcons.summation,
                            width: 25,
                            height: 30,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Products",
                          "Evaluates the convergence of series of multiplications of a given expression",
                          Image.asset(
                            CustomIcons.product,
                            width: 25,
                            height: 50,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Taylor Series",
                          "Gives an approximation of a function up to the given order",
                          Image.asset(
                            CustomIcons.taylorSeries,
                            width: 25,
                            height: 400,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {})
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Limits",
                    "Calculates the value a function approximates to for a certain input",
                    Image.asset(
                      CustomIcons.limit,
                      width: 57,
                      height: 70,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Evaluate limits",
                          "Evaluate the limit of a function up to 3 dimensions",
                          Image.asset(
                            CustomIcons.limits,
                            width: 25,
                            height: 30,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Linear Algebra",
                    "Studies the matrix representation of spaces and their applications",
                    Image.asset(
                      CustomIcons.algebra,
                      width: 57,
                      height: 40,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Matrix Operations",
                          "Provides useful functionalities to add and multiply matrixes ",
                          Image.asset(
                            CustomIcons.operations,
                            width: 25,
                            height: 30,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Invert Matrix",
                          "Inverts the inputed matrix if it is invertible in  record timing",
                          Image.asset(
                            CustomIcons.matrix,
                            width: 25,
                            height: 50,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Matrix Rank",
                          "Calculates the rank of a given matrix promptly ",
                          Image.asset(
                            CustomIcons.rank,
                            width: 25,
                            height: 50,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Determinant",
                          "Finds the value of the determinant of the given matrix ",
                          Image.asset(
                            CustomIcons.determinant,
                            width: 25,
                            height: 100,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                      mathTopicListile(
                          context,
                          "Linear Equations",
                          "Solves a linear system of equations by specifying the values that satisfy all the conditions",
                          Image.asset(
                            CustomIcons.linearEquation,
                            width: 25,
                            height: 10,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                          ),
                          () {}),
                    ]),
              ],
            ),
            _learnMoreWidget(context)
          ],
        ));
  }

  Padding _learnMoreWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
      child: Center(
          child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColorTint50,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.customWhite,
                  ),
                ),
                Text(
                  "Learn more about how MathHelper works",
                  style: TextStyle(
                    color: AppColors.customWhite,
                    fontSize: 14,
                    fontFamily:
                        Theme.of(context).textTheme.labelMedium!.fontFamily,
                  ),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: AppColors.customWhite,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Container mathTopicExpander(BuildContext context, String title,
      String description, Widget topicIcon, List<ListTile> elements) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Provider.of<ThemeManager>(context).themeData ==
                    AppThemeData.lightTheme
                ? AppColors.customBlackTint80
                : AppColors.customBlackTint20,
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: MathematicalTopicWidget(
        title: title,
        description: description,
        topicIcon: topicIcon,
        collapsedIcon: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,
              )
            : const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.customBlackTint80,
              ),
        expandedIcon: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.primaryColor,
              )
            : const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.customBlackTint80,
              ),
        elementsCards: elements,
      ),
    );
  }

  ListTile mathTopicListile(BuildContext context, String title,
      String description, Widget icon, Function onTap) {
    return ListTile(
      leading: icon,
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint80,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle:
          Text(description, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
