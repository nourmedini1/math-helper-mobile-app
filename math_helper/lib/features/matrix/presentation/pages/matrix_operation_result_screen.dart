import 'package:flutter/material.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_operation_success_widget.dart';
import 'package:provider/provider.dart';

class MatrixOperationResultScreen extends StatefulWidget {
  final Operation operation;
  const MatrixOperationResultScreen({super.key, required this.operation});

  @override
  State<MatrixOperationResultScreen> createState() =>
      _MatrixOperationResultScreenState();
}

class _MatrixOperationResultScreenState
    extends State<MatrixOperationResultScreen> {
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
        child: MatrixOperationSuccessWidget(
          title: widget.operation.title,
          matrixA: widget.operation.results[0],
          matrixB: widget.operation.results[1],
          resultMatrix: widget.operation.results[2],
        ),
      ),
    );
  }
}
