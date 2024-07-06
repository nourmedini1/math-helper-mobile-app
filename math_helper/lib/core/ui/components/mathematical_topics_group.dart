import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/strings.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/mathematical_topic.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class MathematicalTopicsGroupWidget extends StatelessWidget {
  const MathematicalTopicsGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _integralMathematicalTopic(context),
            const SizedBox(
              height: 10,
            ),
            _differentialCalculusMathematicalTopic(context),
            const SizedBox(
              height: 10,
            ),
            _differentialCalculusMathematicalTopic(context),
            const SizedBox(
              height: 10,
            ),
            _differentialCalculusMathematicalTopic(context),
            const SizedBox(
              height: 10,
            ),
            _differentialCalculusMathematicalTopic(context),
            const SizedBox(
              height: 10,
            ),
            _differentialCalculusMathematicalTopic(context),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColorTint50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                          fontFamily: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .fontFamily,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_right,
                          color: AppColors.customWhite,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  Container _differentialCalculusMathematicalTopic(BuildContext context) {
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
      child: _integralMathematicalGroup(context),
    );
  }

  Container _integralMathematicalTopic(BuildContext context) {
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
      child: _integralMathematicalGroup(context),
    );
  }

  MathematicalTopicWidget _integralMathematicalGroup(BuildContext context) {
    return MathematicalTopicWidget(
      title: Strings.mathematicalTopicIntegrals,
      description: Strings.mathematicalTopicIntegralsDescription,
      topicIcon: Image.asset(
        CustomIcons.integral,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? null
            : AppColors.customWhite,
      ),
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
      elementsCards: [
        _indefiniteIntegral(context),
        definiteIntegral(context),
      ],
    );
  }

  ListTile definiteIntegral(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        CustomIcons.definiteIntegral,
        width: 15,
        height: 20,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlack
            : AppColors.customWhite,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint80,
      ),
      title: Text(
        Strings.mathematicalTopicDefiniteIntegral,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(Strings.mathematicalTopicSinglePrimitiveDescription,
          style: Theme.of(context).textTheme.labelSmall),
    );
  }

  ListTile _indefiniteIntegral(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        CustomIcons.singlePrimitive,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlack
            : AppColors.customWhite,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint80,
      ),
      title: Text(
        Strings.mathematicalTopicIndefiniteIntegral,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(Strings.mathematicalTopicSinglePrimitiveDescription,
          style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
