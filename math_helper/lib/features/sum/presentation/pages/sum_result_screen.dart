import 'package:flutter/material.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/sum/presentation/widgets/sum_success_widget.dart';
import 'package:provider/provider.dart';

class SumResultScreen extends StatefulWidget {
  final Operation operation;
  const SumResultScreen({super.key, required this.operation});

  @override
  State<SumResultScreen> createState() => _SumResultScreenState();
}

class _SumResultScreenState extends State<SumResultScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint( "ERROR: ${widget.operation.results}");
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
        child: SumSuccessWidget(title :  "Sum Series", expression : widget.operation.results[0],
           result :  widget.operation.results[1], isConvergent : bool.parse(widget.operation.results[2] ),),
      ),
    );
  }

 
}
