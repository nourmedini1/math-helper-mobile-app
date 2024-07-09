import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/search/search_item.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class Functionalities {
  static List<String> searchKeyWords = [
    'indefinite integral',
    'definite integral',
    'derivative',
    'limit',
    'differential equation',
    'invert matrix',
    'determinant',
    'linear equations',
    'rank matrix',
    'matrix operations',
    'complex operations',
    'complex polar form',
    'summation',
    'product',
    'taylor series',
  ];

  static Map<String, SearchItem> getsearchItems(BuildContext context) {
    return {
      'indefinite integral': SearchItem(
        title: 'Indefinite Integrals',
        description:
            "Determines the primitive's expression of a given function",
        leadingIcon: SvgPicture.asset(
          CustomIcons.definiteIntegral,
          width: 15,
          height: 20,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'definite integral': SearchItem(
        title: 'Definite Integrals',
        description: "Determines the area under the curve of a given function",
        leadingIcon: SvgPicture.asset(
          CustomIcons.singlePrimitive,
          width: 15,
          height: 20,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'derivative': SearchItem(
        title: 'Derivatives',
        description: "Determines the rate of change of a given function",
        leadingIcon: Image.asset(
          CustomIcons.derivative,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'limit': SearchItem(
        title: 'Limits',
        description:
            "Determines the behavior of a function as it approaches a certain value",
        leadingIcon: Image.asset(
          CustomIcons.limit,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'differential equation': SearchItem(
        title: 'Differential Equations',
        description:
            "Studies the change of an equation in relation to its slight variations",
        leadingIcon: Image.asset(
          CustomIcons.differentialEquation,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'invert matrix': SearchItem(
        title: 'Invert matrix',
        description:
            "Inverts the inputed matrix if it is invertible in record timing",
        leadingIcon: Image.asset(
          CustomIcons.matrix,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'determinant': SearchItem(
        title: 'Determinant',
        description: "returns the determinant of a given matrix",
        leadingIcon: Image.asset(
          CustomIcons.determinant,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'linear equations': SearchItem(
        title: 'Linear system of equation',
        description: "Solves the inputed linear system of equations",
        leadingIcon: Image.asset(
          CustomIcons.linearEquation,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'rank matrix': SearchItem(
        title: 'Matrix Rank',
        description: "Returns the rank of the inputed matrix",
        leadingIcon: Image.asset(
          CustomIcons.rank,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'matrix operations': SearchItem(
        title: 'Matrix Operations',
        description: "Perform addition or multiplication of matrices",
        leadingIcon: Image.asset(
          CustomIcons.operations,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: () {},
      ),
      'complex operations': SearchItem(
          title: "Complex Operations",
          description: "Add, substract or multiply complex numbers",
          leadingIcon: Image.asset(
            CustomIcons.operations,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: () {}),
      'complex polar form': SearchItem(
          title: "Complex Polar Form",
          description: "returns the polar form of the inputed complex number",
          leadingIcon: Image.asset(
            CustomIcons.polarForm,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: () {}),
      'summation': SearchItem(
          title: "Summations",
          description: "Returns the result of the sum of a numerical series",
          leadingIcon: Image.asset(
            CustomIcons.summation,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: () {}),
      'product': SearchItem(
          title: "Products",
          description:
              "Returns the result of the product of a numerical series",
          leadingIcon: Image.asset(
            CustomIcons.product,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: () {}),
      'taylor series': SearchItem(
          title: "Taylor Series",
          description:
              "Returns the taylor series expansion of a given expression up to the given order",
          leadingIcon: Image.asset(
            CustomIcons.taylorSeries,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: () {}),
    };
  }
}
