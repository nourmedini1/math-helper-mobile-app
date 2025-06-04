import 'package:flutter/material.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_operation_success_widget.dart';
import 'package:provider/provider.dart';

class ComplexOperationsResultScreen extends StatefulWidget {
  final Operation operation;
  const ComplexOperationsResultScreen({super.key, required this.operation});

  @override
  State<ComplexOperationsResultScreen> createState() =>
      _ComplexOperationsResultScreenState();
}

class _ComplexOperationsResultScreenState
    extends State<ComplexOperationsResultScreen> {
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
        child: ComplexOperationSuccessWidget(
          title: widget.operation.title,
          firstComplexNumberAlgebraicForm: widget.operation.results[0],
          firstComplexNumberPolarForm: widget.operation.results[1],
          secondComplexNumberAlgebraicForm: widget.operation.results[2],
          secondComplexNumberPolarForm: widget.operation.results[3],
          resultComplexNumberAlgebraicForm: widget.operation.results[4],
          resultComplexNumberPolarForm: widget.operation.results[5],
        ),
      ),
    );
  }



  
}
