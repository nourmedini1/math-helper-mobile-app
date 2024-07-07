import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/components/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/custom_drawer.dart';
import 'package:math_helper/core/ui/components/mathematical_topics_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

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
          context: context,
          isHomePage: true,
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
          )
        ]),
      ),
    );
  }
}
