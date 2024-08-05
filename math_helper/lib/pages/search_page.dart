import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';

import 'package:math_helper/core/ui/components/loading_component.dart';
import 'package:math_helper/core/ui/components/search/search_app_bar.dart';
import 'package:math_helper/core/ui/components/search/search_item.dart';
import 'package:math_helper/core/ui/cubits/search/search_cubit.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_operation_page.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_operation_result_screen.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_polar_form_page.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_polar_form_result_screen.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/screens/derivative_result_screen.dart';
import 'package:math_helper/features/derivatives/presentation/screens/derivatives_page.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/screens/differential_equations_page.dart';
import 'package:math_helper/features/differential_equations/presentation/screens/differential_equations_result_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/screens/definite_integral_page.dart';
import 'package:math_helper/features/integrals/presentation/screens/integrals_result_screen.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/screens/limits_page.dart';
import 'package:math_helper/features/limits/presentation/screens/limits_result_screen.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/screens/linear_equations_page.dart';
import 'package:math_helper/features/linear_systems/presentation/screens/linear_equations_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/invert_matrix/invert_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:math_helper/features/matrix/presentation/screens/determinant_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/determinant_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/eigen_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/eigen_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/invert_matrix_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/invert_matrix_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_operation_result_screen.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_operations_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_rank_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_rank_result_screen.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/screens/product_page.dart';
import 'package:math_helper/features/product/presentation/screens/product_result_screen.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/screens/sum_page.dart';
import 'package:math_helper/features/sum/presentation/screens/sum_result_screen.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/screens/taylor_series_page.dart';
import 'package:math_helper/features/taylor_series/presentation/screens/taylor_series_result_screen.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchAppBar(controller: controller, theContext: context),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return loadingComponent(context);
            } else if (state is SearchLoaded) {
              return ListView.builder(
                itemCount: state.searchItems.length,
                itemBuilder: (context, index) {
                  return state.searchItems.elementAt(index);
                },
              );
            } else {
              return initialSearchWidget(context);
            }
          },
        ));
  }

  Widget initialSearchWidget(BuildContext context) {
    final List<Operation> operations =
        ic<LocalStorageService>().getOperations().reversed.toList();

    if (operations.isEmpty) {
      final List<String> randomLabels =
          pickRandomElements(Labels.labelsList, 6);
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome! \n Discover these topics with us",
                  style: TextStyle(
                      color: AppColors.primaryColorTint50,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      fontFamily:
                          Theme.of(context).textTheme.titleMedium!.fontFamily),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: randomLabels.length,
                itemBuilder: (context, index) {
                  return mapLabelToSearchItem(
                      randomLabels.elementAt(index), context);
                }),
          ],
        ),
      );
    } else {
      final List<String> topLabels = getTopFiveOperationsIfExists(operations);
      return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Recent Operations",
                style: TextStyle(
                    color: AppColors.primaryColorTint50,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: operations.length,
              itemBuilder: (context, index) {
                return SearchItem(
                  title: operations[index].title,
                  description:
                      "${operations[index].doneAt.year}/${operations[index].doneAt.month}/${operations[index].doneAt.day} ${operations[index].doneAt.hour}:${operations[index].doneAt.minute}",
                  leadingIcon: Image.asset(
                    mapOperationToIcom(operations[index].label),
                    width: 25,
                    height: 400,
                    color: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.customBlack
                        : AppColors.customWhite,
                  ),
                  onTap: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          mapOperationToScreen(operations.elementAt(index)),
                    ));
                  },
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Top 5 Used Operations",
                    style: TextStyle(
                        color: AppColors.primaryColorTint50,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontFamily: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .fontFamily),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: topLabels.length,
                  itemBuilder: (context, index) {
                    return mapLabelToSearchItem(
                        topLabels.elementAt(index), context);
                  }),
            ],
          )
        ]),
      );
    }
  }

  List<T> pickRandomElements<T>(List<T> list, int count) {
    if (list.length < count) {
      throw ArgumentError('The list must contain at least $count elements.');
    }

    final random = Random();
    final pickedElements = <T>{};

    while (pickedElements.length < count) {
      pickedElements.add(list[random.nextInt(list.length)]);
    }

    return pickedElements.toList();
  }

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

  dynamic mapLabelToSearchItem(String label, BuildContext context) {
    switch (label) {
      case Labels.COMPLEX_OPERATIONS_LABEL:
        return SearchItem(
            title: "Complex Operations",
            description:
                "Functionalities to add, substract and multiply complex numbers",
            leadingIcon: Image.asset(
              CustomIcons.operations,
              width: 25,
              height: 30,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<ComplexAdditionBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<ComplexMultiplicationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<ComplexSubstractionBloc>(),
                  ),
                ], child: const ComplexOperationPage()),
              ));
            });

      case Labels.COMPLEX_POLAR_FORM_LABEL:
        return SearchItem(
            title: "Polar Form",
            description: "Provides the polar form of a given complex number",
            leadingIcon: Image.asset(
              CustomIcons.polarForm,
              width: 25,
              height: 50,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) {
                    return ic<PolarFormBloc>();
                  },
                  child: const ComplexPolarFormPage(),
                ),
              ));
            });

      case Labels.DEFINITE_INTEGRAL_LABEL:
        return SearchItem(
            title: "Definite integrals",
            description:
                "Definite integrals measure the surface under a curve for a given interval",
            leadingIcon: SvgPicture.asset(
              CustomIcons.definiteIntegral,
              width: 15,
              height: 20,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<SingleIntegralBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<DoubleIntegralBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<TripleIntegralBloc>(),
                  ),
                ], child: const DefiniteIntegralPage()),
              ));
            });

      case Labels.DERIVATIVE_LABEL:
        return SearchItem(
            title: "Derivatives",
            description:
                "Provides the expression of the function variation or its value in a given point",
            leadingIcon: Image.asset(
              CustomIcons.derivative,
              width: 25,
              height: 30,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<SymbolicDerivativeBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<NumericDerivativeBloc>(),
                  ),
                ], child: const DerivativesPage()),
              ));
            });

      case Labels.DIFFERENTIAL_EQUATIONS_LABEL:
        return SearchItem(
            title: "Differential Equations",
            description:
                "Deals with the very small variation in mathematical function up to 3 orders",
            leadingIcon: Image.asset(
              CustomIcons.differentialEquation,
              width: 25,
              height: 50,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) =>
                        ic<FirstOrderDifferentialEquationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        ic<SecondOrderDifferentialEquationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        ic<ThirdOrderDifferentialEquationBloc>(),
                  ),
                ], child: const DifferentialEquationsPage()),
              ));
            });

      case Labels.DETERMINANT_LABEL:
        return SearchItem(
            title: "Determinant",
            description:
                "Finds the value of the determinant of the given matrix ",
            leadingIcon: Image.asset(
              CustomIcons.determinant,
              width: 25,
              height: 100,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<DeterminantBloc>(),
                  child: const DeterminantPage(),
                ),
              ));
            });

      case Labels.EIGEN_LABEL:
        return SearchItem(
            title: "Eigen values and vectors",
            description: "Finds the eigen value and vector of a given matrix",
            leadingIcon: Image.asset(
              CustomIcons.eigen,
              width: 25,
              height: 100,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<EigenBloc>(),
                  child: const EigenPage(),
                ),
              ));
            });

      case Labels.INVERT_MATRIX_LABEL:
        return SearchItem(
            title: "Invert Matrix",
            description:
                "Inverts the inputed matrix if it is invertible in record timing",
            leadingIcon: Image.asset(
              CustomIcons.matrix,
              width: 25,
              height: 50,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<InvertMatrixBloc>(),
                  child: const InvertMatrixPage(),
                ),
              ));
            });

      case Labels.MATRIX_OPERATIONS_LABEL:
        return SearchItem(
            title: "Matrix Operations",
            description:
                "Provides useful functionalities to add and multiply matrixes ",
            leadingIcon: Image.asset(
              CustomIcons.operations,
              width: 25,
              height: 30,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<AddMatrixBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<MultiplyMatrixBloc>(),
                  ),
                ], child: const MatrixOperationsPage()),
              ));
            });

      case Labels.LINEAR_EQUATIONS_LABEL:
        return SearchItem(
            title: "Linear Equations",
            description:
                "Solves a linear equations by specifying the values that satisfy the linear system",
            leadingIcon: Image.asset(
              CustomIcons.linearEquation,
              width: 25,
              height: 10,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<SolveLinearSystemBloc>(),
                  child: const LinearEquationsPage(),
                ),
              ));
            });

      case Labels.RANK_MATRIX_LABEL:
        return SearchItem(
            title: "Matrix Rank",
            description: "Calculates the rank of a given matrix promptly ",
            leadingIcon: Image.asset(
              CustomIcons.rank,
              width: 25,
              height: 50,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<RankBloc>(),
                  child: const MatrixRankPage(),
                ),
              ));
            });

      case Labels.LIMIT_LABEL:
        return SearchItem(
            title: "Evaluate limits",
            description: "Evaluate the limit of a function up to 3 dimensions",
            leadingIcon: Image.asset(
              CustomIcons.limits,
              width: 25,
              height: 30,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<SingleLimitBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<DoubleLimitBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<TripleLimitBloc>(),
                  ),
                ], child: const LimitsPage()),
              ));
            });

      case Labels.PRODUCT_LABEL:
        return SearchItem(
            title: "Products",
            description:
                "Evaluates the convergence of series of multiplications of a given expression",
            leadingIcon: Image.asset(
              CustomIcons.product,
              width: 25,
              height: 50,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<SymbolicProductBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<NumericProductBloc>(),
                  ),
                ], child: const ProductPage()),
              ));
            });

      case Labels.SUMMATION_LABEL:
        return SearchItem(
            title: "Summations",
            description:
                "Evaluates the convergence of series of summation of a given expression",
            leadingIcon: Image.asset(
              CustomIcons.summation,
              width: 25,
              height: 30,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => ic<SymbolicSumBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => ic<NumericSumBloc>(),
                  ),
                ], child: const SumPage()),
              ));
            });

      case Labels.TAYLOR_SERIES_LABEL:
        return SearchItem(
            title: "Taylor Series",
            description:
                "Gives an approximation of a function up to the given order",
            leadingIcon: Image.asset(
              CustomIcons.taylorSeries,
              width: 25,
              height: 400,
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
            ),
            onTap: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<ExpandTaylorSeriesBloc>(),
                  child: const TaylorSeriesPage(),
                ),
              ));
            });
    }
  }

  List<String> getTopFiveOperationsIfExists(List<Operation> operations) {
    Map<String, int> occurrences = {};
    for (var operation in operations) {
      occurrences[operation.label] = (occurrences[operation.label] ?? 0) + 1;
    }

    List<MapEntry<String, int>> sortedEntries = occurrences.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<String> sortedOperations =
        sortedEntries.map((entry) => entry.key).toList();

    return sortedOperations.length >= 5
        ? sortedOperations.sublist(0, 5)
        : sortedOperations;
  }
}
