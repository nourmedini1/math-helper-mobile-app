import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/search/search_item.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/cubit/addition_cubit/addition_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/multiplication_cubit/multiplication_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/polar_form_cubit/polar_form_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/substraction_cubit/substraction_cubit.dart';
import 'package:math_helper/features/complex/presentation/pages/complex_operation_page.dart';
import 'package:math_helper/features/complex/presentation/pages/complex_polar_form_page.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_derivative_fields/numeric_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_partial_derivative/numeric_partial_derivative_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_derivative_fields/symbolic_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_partial_derivative/symbolic_partial_derivative_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/pages/derivatives_page.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/first_order_coefficients/first_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/first_order_constraints/first_order_constraints_text_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_coefficients/second_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_constraints/second_order_constraints_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/third_order_coefficents/third_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/third_order_constraints/third_order_constraints_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/pages/differential_equations_page.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/double_fields/double_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/double_limits_text/double_definite_integral_limits_text_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/single_fields/single_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/single_limits_text/single_definite_integral_limits_text_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/triple_fields/triple_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/triple_limits_text/triple_definite_integral_limit_text_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/indefinite_integral/indefinite_double_fields/indefinite_double_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/indefinite_integral/indefinite_single_fields/indefinite_single_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/indefinite_integral/indefinite_triple_fields/indefinite_triple_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/pages/definite_integral_page.dart';
import 'package:math_helper/features/integrals/presentation/pages/indefinite_integral_page.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/cubit/double/double_limit_fields/double_limit_fields_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/double/double_limit_text/double_limit_text_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/single/single_limit_fields/single_limit_fields_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/single/single_limit_text/single_limit_text_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/triple/triple_limit_fields/triple_limit_fields_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/triple/triple_limit_text/triple_limit_text_cubit.dart';
import 'package:math_helper/features/limits/presentation/pages/limits_page.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/screens/linear_equations_page.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/invert_matrix/invert_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_first_matrix/addition_first_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_first_matrix_fields/addition_first_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_second_matrix/addition_second_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_second_matrix_fields/addition_second_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/determinant/determinant_matrix/determinant_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/determinant/determinant_matrix_fields/determinant_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/eigen/eigen_matrix/eigen_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/eigen/eigen_matrix_fields/eigen_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/invert_matrix/invert_matrix/invert_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/invert_matrix/invert_matrix_fields/invert_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_first_matrix/multiplication_first_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_first_matrix_fields/multiplication_first_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_second_matrix/multiplication_second_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_second_matrix_fields/multiplication_second_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/rank/rank_matrix/rank_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/rank/rank_matrix_fields/rank_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/pages/determinant_page.dart';
import 'package:math_helper/features/matrix/presentation/pages/eigen_page.dart';
import 'package:math_helper/features/matrix/presentation/pages/invert_matrix_page.dart';
import 'package:math_helper/features/matrix/presentation/pages/matrix_operations_page.dart';
import 'package:math_helper/features/matrix/presentation/pages/matrix_rank_page.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/cubit/numeric/numeric_product_fields/numeric_product_fields_cubit.dart';
import 'package:math_helper/features/product/presentation/cubit/numeric/numeric_product_text/numeric_product_text_cubit.dart';
import 'package:math_helper/features/product/presentation/cubit/symbolic/symbolic_product_fields/symbolic_product_fields_cubit.dart';
import 'package:math_helper/features/product/presentation/pages/product_page.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/cubit/numeric/numeric_sum_fields/numeric_sum_fields_cubit.dart';
import 'package:math_helper/features/sum/presentation/cubit/numeric/numeric_sum_text/numeric_sum_text_cubit.dart';
import 'package:math_helper/features/sum/presentation/cubit/symbolic/symbolic_sum_fields/symbolic_sum_fields_cubit.dart';
import 'package:math_helper/features/sum/presentation/pages/sum_page.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/cubit/taylor_series/taylor_series_fields_cubit.dart';
import 'package:math_helper/features/taylor_series/presentation/pages/taylor_series_page.dart';
import 'package:provider/provider.dart';

class Functionalities {
  static List<String> searchKeyWords = [
    'indefinite integral',
    'definite integral',
    'derivative',
    'limit',
    'differential equation',
    'invert matrix',
    'determinant',
    'linear equations',
    'rank matrix',
    'matrix operations',
    'complex operations',
    'complex polar form',
    'summation',
    'product',
    'taylor series',
    'eigen values and vectors'
  ];

  static Map<String, SearchItem> getsearchItems(BuildContext context) {
    return {
      'indefinite integral': SearchItem(
        title: 'Indefinite Integrals',
        description:
            "Determines the primitive's expression of a given function",
        leadingIcon: SvgPicture.asset(
          CustomIcons.definiteIntegral,
          width: 15,
          height: 20,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                            BlocProvider(
                              create: (context) => ic<SinglePrimitiveBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<DoublePrimitiveBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<TriplePrimitiveBloc>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<IndefiniteDoubleFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<IndefiniteTripleFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<IndefiniteSingleFieldsCubit>(),
                            ),
                          ], child: const IndefinitePrimitivePage()),
          ));
        },
      ),
      'definite integral': SearchItem(
        title: 'Definite Integrals',
        description: "Determines the area under the curve of a given function",
        leadingIcon: SvgPicture.asset(
          CustomIcons.singlePrimitive,
          width: 15,
          height: 20,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
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
                            BlocProvider(
                              create: (context) => ic<SingleFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<DoubleFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<TripleFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<SingleDefiniteIntegralLimitsTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<DoubleDefiniteIntegralLimitsTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<TripleDefiniteIntegralLimitTextCubit>(),
                            ),
                          ], child: const DefiniteIntegralPage()),
          ));
        },
      ),
      'derivative': SearchItem(
        title: 'Derivatives',
        description: "Determines the rate of change of a given function",
        leadingIcon: Image.asset(
          CustomIcons.derivative,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                            BlocProvider(
                              create: (context) =>
                                  ic<SymbolicDerivativeFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<NumericDerivativeFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<SymbolicPartialDerivativeCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<NumericPartialDerivativeCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<SymbolicDerivativeBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<NumericDerivativeBloc>(),
                            ),
                          ], child: const DerivativesPage()),
          ));
        },
      ),
      'limit': SearchItem(
        title: 'Limits',
        description:
            "Determines the behavior of a function as it approaches a certain value",
        leadingIcon: Image.asset(
          CustomIcons.limit,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>MultiBlocProvider(providers: [
                            BlocProvider(
                              create: (context) => ic<SingleLimitBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<DoubleLimitBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<TripleLimitBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<SingleLimitTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<DoubleLimitTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<TripleLimitTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<SingleLimitFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<DoubleLimitFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<TripleLimitFieldsCubit>(),
                            ),
                          ], child: const LimitsPage()),
          ));
        },
      ),
      'differential equation': SearchItem(
        title: 'Differential Equations',
        description:
            "Studies the change of an equation in relation to its slight variations",
        leadingIcon: Image.asset(
          CustomIcons.differentialEquation,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
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
                            BlocProvider(
                              create: (context) =>
                                  ic<FirstOrderCoefficientsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<SecondOrderCoefficientsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<ThirdOrderCoefficientsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<FirstOrderConstraintsTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<SecondOrderConstraintsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<ThirdOrderConstraintsCubit>(),
                            ),
                          ], child: const DifferentialEquationsPage()),
          ));
        },
      ),
      'invert matrix': SearchItem(
        title: 'Invert matrix',
        description:
            "Inverts the inputed matrix if it is invertible in record timing",
        leadingIcon: Image.asset(
          CustomIcons.matrix,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => ic<InvertMatrixBloc>(),
                              ),
                              BlocProvider(
                                create: (context) => ic<InvertMatrixCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<InvertMatrixFieldsCubit>(),
                              ),
                            ],
                            child: const InvertMatrixPage(),
                          ),
          ));
        },
      ),
      'determinant': SearchItem(
        title: 'Determinant',
        description: "returns the determinant of a given matrix",
        leadingIcon: Image.asset(
          CustomIcons.determinant,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => ic<DeterminantBloc>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<DeterminantMatrixCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<DeterminantMatrixFieldsCubit>(),
                              ),
                            ],
                            child: const DeterminantPage(),
                          ),
          ));
        },
      ),
      'linear equations': SearchItem(
        title: 'Linear system of equation',
        description: "Solves the inputed linear system of equations",
        leadingIcon: Image.asset(
          CustomIcons.linearEquation,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
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
        },
      ),
      'rank matrix': SearchItem(
        title: 'Matrix Rank',
        description: "Returns the rank of the inputed matrix",
        leadingIcon: Image.asset(
          CustomIcons.rank,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlack
              : AppColors.customWhite,
        ),
        onTap: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>  MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => ic<RankBloc>(),
                              ),
                              BlocProvider(
                                create: (context) => ic<RankMatrixCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<RankMatrixFieldsCubit>(),
                              ),
                            ],
                            child: const RankPage(),
                          ),
          ));
        },
      ),
      'matrix operations': SearchItem(
        title: 'Matrix Operations',
        description: "Perform addition or multiplication of matrices",
        leadingIcon: Image.asset(
          CustomIcons.operations,
          width: 25,
          height: 70,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
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
                            BlocProvider(
                              create: (context) =>
                                  ic<MultiplicationFirstMatrixCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<MultiplicationFirstMatrixFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<MultiplicationSecondMatrixFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<MultiplicationSecondMatrixCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<AdditionFirstMatrixCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<AdditionFirstMatrixFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<AdditionSecondMatrixFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<AdditionSecondMatrixCubit>(),
                            ),
                          ], child: const MatrixOperationsPage()),
          ));
        },
      ),
      'eigen values and vectors': SearchItem(
          title: "Eigen Values and Vectors",
          description: "Finds the eigen value and vector of a given matrix",
          leadingIcon: Image.asset(
            CustomIcons.eigen,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: (context) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => ic<EigenBloc>(),
                              ),
                              BlocProvider(
                                create: (context) => ic<EigenMatrixCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<EigenMatrixFieldsCubit>(),
                              ),
                            ],
                            child: const EigenPage(),
                          ),
            ));
          }),
      'complex polar form': SearchItem(
          title: "Complex Polar Form",
          description: "returns the polar form of the inputed complex number",
          leadingIcon: Image.asset(
            CustomIcons.polarForm,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: (context) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) {
                                  return ic<PolarFormBloc>();
                                },
                              ),
                              BlocProvider(
                                create: (context) => ic<PolarFormCubit>(),
                              ),
                            ],
                            child: const ComplexPolarFormPage(),
                          ),
            ));
          }),
       'complex operations': SearchItem(
          title: "Complex Operations",
          description: "ërforms addition, substraction and multiplication of complex numbers",
          leadingIcon: Image.asset(
            CustomIcons.complexAnalysis,
            width: 25,
            height: 70,
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
                              create: (context) => ic<AdditionCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<SubstractionCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<MultiplicationCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<ComplexAdditionBloc>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<ComplexMultiplicationBloc>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<ComplexSubstractionBloc>(),
                            ),
                          ], child: const ComplexOperationPage()),
            ));
          }),
      'summation': SearchItem(
          title: "Summations",
          description: "Returns the result of the sum of a numerical series",
          leadingIcon: Image.asset(
            CustomIcons.summation,
            width: 25,
            height: 70,
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
                            BlocProvider(
                              create: (context) => ic<NumericSumTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<SymbolicSumFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<NumericSumFieldsCubit>(),
                            ),
                          ], child: const SumPage()),
            ));
          }),
      'product': SearchItem(
          title: "Products",
          description:
              "Returns the result of the product of a numerical series",
          leadingIcon: Image.asset(
            CustomIcons.product,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: (context) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>MultiBlocProvider(providers: [
                            BlocProvider(
                              create: (context) => ic<SymbolicProductBloc>(),
                            ),
                            BlocProvider(
                              create: (context) => ic<NumericProductBloc>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<NumericProductTextCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<SymbolicProductFieldsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ic<NumericProductFieldsCubit>(),
                            ),
                          ], child: const ProductPage()),
            ));
          }),
      'taylor series': SearchItem(
          title: "Taylor Series",
          description:
              "Returns the taylor series expansion of a given expression up to the given order",
          leadingIcon: Image.asset(
            CustomIcons.taylorSeries,
            width: 25,
            height: 70,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
          ),
          onTap: (context) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    ic<ExpandTaylorSeriesBloc>(),
                              ),
                              BlocProvider(
                                create: (context) => ic<TaylorSeriesFieldsCubit>(),
                              ),
                            ],
                            child: const TaylorSeriesPage(),
                          ),
            ));
          }),
    };
  }
}
