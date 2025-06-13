import 'package:flutter/material.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/widgets/eigen/eigen_success_widget.dart';
import 'package:provider/provider.dart';

class EigenResultScreen extends StatefulWidget {
  final Operation operation;
  const EigenResultScreen({super.key, required this.operation});

  @override
  State<EigenResultScreen> createState() => _EigenResultScreenState();
}

class _EigenResultScreenState extends State<EigenResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
          context: context,
          tabController: null,
          hasTabBar: false,
          appBarBottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Divider(
              height: 1,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.customBlackTint60,
            ),
          ),
          hasHomeIcon: true),
      drawer: const CustomDrawer(),
      body: Center(
        child: EigenSuccessWidget(
          title : "Eigen Values & Vectors",
          matrix: widget.operation.results[0],
          value : widget.operation.results[1],
          vector : widget.operation.results[2],
        ),
      ),
    );
  }

}