import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/home_screen_menu/mathematical_topics_group.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_operation_result_screen.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_polar_form_result_screen.dart';
import 'package:math_helper/features/derivatives/presentation/screens/derivative_result_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/screens/differential_equations_result_screen.dart';
import 'package:math_helper/features/integrals/presentation/screens/integrals_result_screen.dart';
import 'package:math_helper/features/limits/presentation/screens/limits_result_screen.dart';
import 'package:math_helper/features/linear_systems/presentation/screens/linear_equations_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/determinant_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/eigen_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/invert_matrix_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_operation_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_rank_result_screen.dart';
import 'package:math_helper/features/product/presentation/screens/product_result_screen.dart';
import 'package:math_helper/features/sum/presentation/screens/sum_result_screen.dart';
import 'package:math_helper/features/taylor_series/presentation/screens/taylor_series_result_screen.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  late List<Operation> operations;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 100, vsync: this);
    operations = getOperations();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          tabController: tabController,
          hasHomeIcon: false,
          context: context,
          hasTabBar: true,
          appBarBottom: homeTabBar(context),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 0, left: 24),
                  child: Text(
                    "Mathematical topics",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const MathematicalTopicsGroupWidget(),
              ],
            ),
          ),
          historyPage(context, operations),
          Container(),
        ]),
      ),
    );
  }

  PreferredSize homeTabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Column(
        children: [
          Divider(
            height: 1,
            color: Provider.of<ThemeManager>(context).themeData ==
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
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: AppColors.primaryColorTint50,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: AppColors.customWhite,
                  unselectedLabelColor:
                      Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customBlackTint90,
                  tabs: const [
                    TabBarItem(
                      title: 'Home',
                      icon: Icon(
                        Icons.home_rounded,
                      ),
                    ),
                    TabBarItem(
                        title: 'History',
                        icon: Icon(Icons.watch_later_outlined)),
                    TabBarItem(
                        title: 'Statistics', icon: Icon(Icons.bar_chart)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Operation> getOperations() =>
      ic<LocalStorageService>().getOperations().reversed.toList();

  dynamic mapOperationToScreen(Operation operation) {
    switch (operation.label) {
      case Labels.COMPLEX_OPERATIONS_LABEL:
        return ComplexOperationsResultScreen(operation: operation);
      case Labels.COMPLEX_POLAR_FORM_LABEL:
        return ComplexPolarFormResultScreen(operation: operation);
      case Labels.DEFINITE_INTEGRAL_LABEL:
        return IntegralsResultScreen(operation: operation);
      case Labels.INDEFINITE_INTEGRAL_LABEL:
        return IntegralsResultScreen(operation: operation);
      case Labels.DERIVATIVE_LABEL:
        return DerivativeResultScreen(operation: operation);
      case Labels.DIFFERENTIAL_EQUATIONS_LABEL:
        return DifferentialEquationsResultScreen(operation: operation);
      case Labels.DETERMINANT_LABEL:
        return DeterminantResultScreen(operation: operation);
      case Labels.EIGEN_LABEL:
        return EigenResultScreen(operation: operation);
      case Labels.INVERT_MATRIX_LABEL:
        return InvertMatrixResultScreen(operation: operation);
      case Labels.MATRIX_OPERATIONS_LABEL:
        return MatrixOperationResultScreen(operation: operation);
      case Labels.LINEAR_EQUATIONS_LABEL:
        return LinearEquationsResultScreen(operation: operation);
      case Labels.RANK_MATRIX_LABEL:
        return RankResultScreen(operation: operation);
      case Labels.LIMIT_LABEL:
        return LimitsResultScreen(operation: operation);
      case Labels.PRODUCT_LABEL:
        return ProductResultScreen(operation: operation);
      case Labels.SUMMATION_LABEL:
        return SumResultScreen(operation: operation);
      case Labels.TAYLOR_SERIES_LABEL:
        return TaylorSeriesResultScreen(operation: operation);
    }
  }

  Widget historyPage(BuildContext context, List<Operation> operations) {
    return RefreshIndicator(
      color: Provider.of<ThemeManager>(context, listen: false).themeData ==
              AppThemeData.lightTheme
          ? AppColors.primaryColorTint50
          : AppColors.customBlackTint40,
      onRefresh: () {
        setState(() {
          operations = getOperations();
        });
        return Future<void>.value();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: operations.length,
        itemBuilder: (context, index) {
          final operation = operations[index];
          return TimelineTile(
              isFirst: index == 0,
              isLast: index == operations.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 70,
                height: 70,
                indicator: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.primaryColorTint50
                          : AppColors.customBlackTint40,
                    ),
                    child: const Center(
                      child: Icon(Icons.done),
                    ),
                  ),
                ),
              ),
              endChild: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Provider.of<ThemeManager>(context).themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.primaryColor,
                    ),
                    tileColor: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.customBlackTint40,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => mapOperationToScreen(operation),
                      ));
                    },
                    leading: Image.asset(
                      mapOperationToIcom(operations[index].label),
                      width: 25,
                      height: 400,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    title: Text(operation.title,
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                      "${operations[index].doneAt.year}/${operations[index].doneAt.month}/${operations[index].doneAt.day} ${operations[index].doneAt.hour}:${operations[index].doneAt.minute}",
                      style: TextStyle(
                          color:
                              Provider.of<ThemeManager>(context, listen: false)
                                          .themeData ==
                                      AppThemeData.lightTheme
                                  ? AppColors.customBlack
                                  : AppColors.customWhite,
                          fontSize: 12,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .fontFamily),
                    )),
              ));
        },
      ),
    );
  }

  dynamic mapOperationToIcom(String label) {
    switch (label) {
      case Labels.COMPLEX_OPERATIONS_LABEL:
        return CustomIcons.operations;
      case Labels.COMPLEX_POLAR_FORM_LABEL:
        return CustomIcons.polarForm;
      case Labels.DEFINITE_INTEGRAL_LABEL:
        return CustomIcons.integral;
      case Labels.INDEFINITE_INTEGRAL_LABEL:
        return CustomIcons.integral;
      case Labels.DERIVATIVE_LABEL:
        return CustomIcons.derivative;
      case Labels.DIFFERENTIAL_EQUATIONS_LABEL:
        return CustomIcons.differentialCalculus;
      case Labels.DETERMINANT_LABEL:
        return CustomIcons.determinant;
      case Labels.EIGEN_LABEL:
        return CustomIcons.eigen;
      case Labels.INVERT_MATRIX_LABEL:
        return CustomIcons.matrix;
      case Labels.MATRIX_OPERATIONS_LABEL:
        return CustomIcons.operations;
      case Labels.LINEAR_EQUATIONS_LABEL:
        return CustomIcons.linearEquation;
      case Labels.RANK_MATRIX_LABEL:
        return CustomIcons.rank;
      case Labels.LIMIT_LABEL:
        return CustomIcons.limit;
      case Labels.PRODUCT_LABEL:
        return CustomIcons.product;
      case Labels.SUMMATION_LABEL:
        return CustomIcons.summation;
      case Labels.TAYLOR_SERIES_LABEL:
        return CustomIcons.taylorSeries;
    }
  }
}
