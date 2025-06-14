import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/linear_systems/presentation/widgets/linear_system_screen.dart';
import 'package:provider/provider.dart';

class LinearEquationsPage extends StatefulWidget {
  const LinearEquationsPage({super.key});

  @override
  State<LinearEquationsPage> createState() => _LinearEquationsPageState();
}

class _LinearEquationsPageState extends State<LinearEquationsPage> {
  late TextEditingController numberOfEquationsController;
  late TextEditingController variablesController;

  late List<TextEditingController> equationsControllers;
  late List<TextEditingController> secondHnadSidesControllers;

  @override
  void initState() {
    numberOfEquationsController = TextEditingController();
    variablesController = TextEditingController();
    equationsControllers = [];
    secondHnadSidesControllers = [];
    super.initState();
  }

  @override
  void dispose() {
    numberOfEquationsController.dispose();
    variablesController.dispose();
    for (var controller in equationsControllers) {
      controller.dispose();
    }
    for (var controller in secondHnadSidesControllers) {
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
        child: LinearSystemScreen(
          nbEquationsController: numberOfEquationsController,
          variablesController: variablesController,
          equationsControllers: equationsControllers,
          rightHandSideControllers: secondHnadSidesControllers,
        ),
      ),
    );
  }

 
}
