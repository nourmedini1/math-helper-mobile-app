import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/strings.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/pages/complex_operation_result_page.dart';
import 'package:math_helper/features/complex/presentation/pages/complex_polar_form_result_page.dart';
import 'package:math_helper/features/derivatives/presentation/pages/derivative_result_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/pages/differential_equations_result_screen.dart';
import 'package:math_helper/features/integrals/presentation/pages/integrals_result_screen.dart';
import 'package:math_helper/features/limits/presentation/pages/limits_result_screen.dart';
import 'package:math_helper/features/linear_systems/presentation/pages/linear_equations_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/pages/eigen_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/pages/invert_matrix_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/pages/matrix_operation_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/pages/matrix_rank_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/pages/determinant_result_screen.dart';
import 'package:math_helper/features/product/presentation/pages/product_result_screen.dart';
import 'package:math_helper/features/sum/presentation/pages/sum_result_screen.dart';
import 'package:math_helper/features/taylor_series/presentation/pages/taylor_series_result_screen.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late List<Operation> operations;

  @override
  void initState() {
    super.initState();
    operations = getOperations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.customWhite
            : AppColors.customBlackTint20,
        width: MediaQuery.of(context).size.width * 0.85,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed header
              Container(
                width: double.infinity,
                height: 120,
                alignment: Alignment.center,
                color: Provider.of<ThemeManager>(context).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customWhite
                    : AppColors.customBlackTint20,
                child: Text(
                  Strings.appName,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Container(
              width: double.infinity,
              height: 70,
              alignment: Alignment.centerLeft,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.customWhite
                  : AppColors.customBlackTint20,
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextFieldLabel(label: "Recent Operations",),
              )
                          ),
              // Only the timeline/history is scrollable
              Expanded(
                child: historyPage(context, operations),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget historyPage(BuildContext context, List<Operation> operations) {
    return RefreshIndicator(
      color: Provider.of<ThemeManager>(context, listen: false).themeData ==
              AppThemeData.lightTheme
          ? AppColors.primaryColorTint50
          : AppColors.customBlackTint40,
      onRefresh: () async {
        setState(() {
          operations = getOperations();
        });
        return Future.value();
      },
      child: operations.isEmpty
          ? const Center(child: Text("No operations history yet"))
          : ListView.builder(
              shrinkWrap: false,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              itemCount: operations.length,
              itemBuilder: (context, index) {
                final operation = operations[index];
                return TimelineTile(
                    isFirst: index == 0,
                    isLast: index == operations.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 40, // Reduced from 70
                      height: 40, // Reduced from 70
                      indicator: Padding(
                        padding:
                            const EdgeInsets.only(top: 10), // Reduced from 30
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.primaryColorTint50
                                : AppColors.customBlackTint40,
                          ),
                          child: const Center(
                            child: Icon(Icons.done, size: 16), // Smaller icon
                          ),
                        ),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 6, right: 6), // Reduced padding
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0), // Compact padding
                          dense: true, // Makes ListTile more compact
                          visualDensity: const VisualDensity(
                              horizontal: -2,
                              vertical: -2), // Even more compact
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12.0), // Smaller radius
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.primaryColor,
                            size: 14, // Smaller icon
                          ),
                          tileColor:
                              Provider.of<ThemeManager>(context, listen: false)
                                          .themeData ==
                                      AppThemeData.lightTheme
                                  ? AppColors.primaryColorTint50
                                  : AppColors.customBlackTint40,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  mapOperationToScreen(operation),
                            ));
                          },
                          leading: Image.asset(
                            mapOperationToIcom(operations[index].label),
                            width: 20, // Reduced from 25
                            height: 20, // Reduced from 40
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ),
                          title: Text(
                            operation.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontSize: 13, // Smaller font size
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "${operations[index].doneAt.year}/${operations[index].doneAt.month}/${operations[index].doneAt.day} ${operations[index].doneAt.hour.toString().padLeft(2, '0')}:${operations[index].doneAt.minute.toString().padLeft(2, '0')}",
                            style: TextStyle(
                                color: Provider.of<ThemeManager>(context,
                                                listen: false)
                                            .themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customWhite,
                                fontSize: 10, // Smaller text
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
