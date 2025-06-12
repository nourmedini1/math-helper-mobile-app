import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/function_plotting/presentation/bloc/function_plotting_bloc.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/first_graph_fields/first_graph_fields_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/second_graph_fields/second_graph_fields_cubit.dart';
import 'package:math_helper/pages/graph_page.dart';
import 'package:math_helper/pages/topics_page.dart';
import 'package:provider/provider.dart';

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
          const TopicsPage(),
          MultiBlocProvider(
            providers: [
        BlocProvider(
          create: (context) => ic<FunctionPlottingBloc>(),
        ),
        BlocProvider(
          create: (context) => ic<GraphCubit>(),
        ),
        BlocProvider(create: (context) => ic<FirstGraphFieldsCubit>()),
        BlocProvider(create: (context) => ic<SecondGraphFieldsCubit>()
        ),
      ],
            child: const GraphPage(),
          ),
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
                      title: 'Solver',
                      icon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Bootstrap.calculator,
                          size: 18,
                        ),
                      ),
                    ),
                    TabBarItem(
                        title: 'Graphs',
                        icon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(Bootstrap.graph_up, size: 18),
                        )),
                    TabBarItem(
                        title: 'Tutor',
                        icon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Bootstrap.robot,
                            size: 18,
                          ),
                        )),
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
