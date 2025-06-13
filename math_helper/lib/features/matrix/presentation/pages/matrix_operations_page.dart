import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/widgets/add_matrix/matrix_addition_screen.dart';
import 'package:math_helper/features/matrix/presentation/widgets/multiply_matrix/matrix_multiplication_screen.dart';
import 'package:provider/provider.dart';

class MatrixOperationsPage extends StatefulWidget {
  const MatrixOperationsPage({super.key});

  @override
  State<MatrixOperationsPage> createState() => _MatrixOperationsPageState();
}

class _MatrixOperationsPageState extends State<MatrixOperationsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController additonFirstRowsController;
  late TextEditingController additionFirstColumnsController;

  late TextEditingController additionSecondRowsController;
  late TextEditingController additionSecondColumnsController;

  late List<TextEditingController> additionFirstControllers;
  late List<TextEditingController> additionSecondControllers;

  late TextEditingController multiplicationFirstRowsController;
  late TextEditingController multiplicationFirstColumnsController;

  late TextEditingController multiplicationSecondRowsController;
  late TextEditingController multiplicationSecondColumnsController;
  
  late List<TextEditingController> multiplicationFirstControllers;
  late List<TextEditingController> multiplicationSecondControllers;


  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    additonFirstRowsController = TextEditingController();
    additionFirstColumnsController = TextEditingController();
    additionSecondRowsController = TextEditingController();
    additionSecondColumnsController = TextEditingController();

    multiplicationFirstRowsController = TextEditingController();
    multiplicationFirstColumnsController = TextEditingController();
    multiplicationSecondRowsController = TextEditingController();
    multiplicationSecondColumnsController = TextEditingController();
    additionFirstControllers = [];
    additionSecondControllers = [];
    multiplicationFirstControllers = [];
    multiplicationSecondControllers = [];


    super.initState();
  }

  @override
  void dispose() {
    for (var controller in additionFirstControllers) {
      controller.dispose();
    }
    for (var controller in additionSecondControllers) {
      controller.dispose();
    }
    for (var controller in multiplicationFirstControllers) {
      controller.dispose();
    }
    for (var controller in multiplicationSecondControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            context: context,
            tabController: tabController,
            hasTabBar: true,
            appBarBottom: appBarBottom(context),
            hasHomeIcon: true),
        drawer: const CustomDrawer(),
        body: TabBarView(controller: tabController, children: [
          Center(child: MatrixAdditionScreen(
            firstMatrixRowsController: additonFirstRowsController, 
            firstMatrixColumnsController: additionFirstColumnsController, 
            secondMatrixRowsController: additionSecondRowsController, 
            secondMatrixColumnsController: additionSecondColumnsController, 
            firstMatrixControllers: additionFirstControllers, 
            secondMatrixControllers: additionSecondControllers,)

          ),
          Center(
            child: MatrixMultiplicationScreen(
              firstMatrixRowsController: multiplicationFirstRowsController,
              firstMatrixColumnsController: multiplicationFirstColumnsController,
              secondMatrixRowsController: multiplicationSecondRowsController,
              secondMatrixColumnsController: multiplicationSecondColumnsController,
              firstMatrixControllers: multiplicationFirstControllers,
              secondMatrixControllers: multiplicationSecondControllers,
            ),
          )
        ]));
  }
  PreferredSize appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Column(
        children: [
          Divider(
            height: 1,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColorTint50
                    : AppColors.customBlackTint60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Provider.of<ThemeManager>(context).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint90
                      : AppColors.customDarkGrey,
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator:  BoxDecoration(
                    color: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: AppColors.customWhite,
                  unselectedLabelColor:
                      Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customBlackTint90,
                  tabs: const [
                    TabBarItem(
                      title: ' Add',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Multiply',
                        icon: Icon(Icons.bar_chart, size: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  


   

}
