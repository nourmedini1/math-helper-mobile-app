import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/widgets/screens/taylor_series_initial_screen.dart';
import 'package:math_helper/features/taylor_series/presentation/widgets/screens/taylor_series_success_screen.dart';
import 'package:provider/provider.dart';

class TaylorSeriesPage extends StatefulWidget {
  const TaylorSeriesPage({super.key});

  @override
  State<TaylorSeriesPage> createState() => _TaylorSeriesPageState();
}

class _TaylorSeriesPageState extends State<TaylorSeriesPage> {
  late TextEditingController expressionController;
  late TextEditingController variableController;
  late TextEditingController orderController;
  late TextEditingController nearController;
  late List<TextEditingController> controllers;
  bool isFieldsReady = false;
  @override
  void initState() {
    super.initState();
    expressionController = TextEditingController();
    variableController = TextEditingController();
    orderController = TextEditingController();
    nearController = TextEditingController();
    controllers = [
      expressionController,
      variableController,
      orderController,
      nearController
    ];
  }

  @override
  void dispose() {
    expressionController.dispose();
    variableController.dispose();
    orderController.dispose();
    nearController.dispose();
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
        child: BlocConsumer<ExpandTaylorSeriesBloc, ExpandTaylorSeriesState>(
          listener: (context, state) {
            if (state is ExpandTaylorSeriesFailure) {
              showToast(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ExpandTaylorSeriesInitial) {
              return TaylorSeriesInitialScreen(
                expressionController: expressionController, 
                variableController: variableController, 
                orderController: orderController, 
                nearController: nearController);
            } else if (state is ExpandTaylorSeriesLoading) {
              return const LoadingScreen();
            } else if (state is ExpandTaylorSeriesSuccess) {
              return TaylorSeriesSuccessScreen(
                title: "Taylor Series",
                expression: state.response.expression,
                result: state.response.result,
                );
            } else {
              return TaylorSeriesInitialScreen(
                expressionController: expressionController, 
                variableController: variableController, 
                orderController: orderController, 
                nearController: nearController);
            }
          },
        ) ),
    );
  }

  void showToast(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.customWhite,
          ),
        ),
        backgroundColor: AppColors.customRed,
      ),
    );
  }


}
