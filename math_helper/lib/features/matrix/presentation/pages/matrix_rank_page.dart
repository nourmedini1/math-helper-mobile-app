import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/widgets/rank/rank_screen.dart';
import 'package:provider/provider.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  late TextEditingController rowsController;
  late TextEditingController columnsController;

  late List<TextEditingController> matrixControllers;

  @override
  void initState() {
    rowsController = TextEditingController();
    columnsController = TextEditingController();
    matrixControllers = [];
    super.initState();
  }

  @override
  void dispose() {
    rowsController.dispose();
    columnsController.dispose();
    for (var controller in matrixControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: RankScreen(
          rowsController: rowsController,
          columnsController: columnsController,
          matrixControllers: matrixControllers,
        ),
      ),
    );
  }




}