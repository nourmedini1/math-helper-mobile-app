import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_helper/core/assets/icons/icons.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/home_screen_menu/mathematical_topic.dart';
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
import 'package:math_helper/features/linear_systems/presentation/cubit/linear_system_equations/linear_system_equations_cubit.dart';
import 'package:math_helper/features/linear_systems/presentation/cubit/linear_system_equations_fields/linear_system_equations_fields_cubit.dart';
import 'package:math_helper/features/linear_systems/presentation/pages/linear_equations_page.dart';
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
import 'package:math_helper/pages/about_page.dart';
import 'package:provider/provider.dart';

class MathematicalTopicsGroupWidget extends StatelessWidget {
  const MathematicalTopicsGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mathTopicExpander(
                    context,
                    "Integrals",
                    "Integrals measure the area under curves up to 3 dimensions",
                    Image.asset(
                      CustomIcons.integral,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? null
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Definite integrals",
                          "Definite integrals measure the surface under a curve for a given interval",
                          SvgPicture.asset(
                            CustomIcons.definiteIntegral,
                            width: 15,
                            height: 20,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                      mathTopicListile(
                          context,
                          "Indefinite Integrals",
                          "Determines the primitive's expression of a given function",
                          SvgPicture.asset(
                            CustomIcons.singlePrimitive,
                            width: 15,
                            height: 20,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      })
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Differential Calculus",
                    "Differential calculus studies the variation of a mathematical function",
                    Image.asset(
                      CustomIcons.differentialCalculus,
                      width: 57,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Derivatives",
                          "Provides the expression of the function variation or its value in a given point",
                          Image.asset(
                            CustomIcons.derivative,
                            width: 25,
                            height: 30,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                      mathTopicListile(
                          context,
                          "Differential Equations",
                          "Deals with the very small variation in mathematical function up to 3 orders",
                          Image.asset(
                            CustomIcons.differentialEquation,
                            width: 25,
                            height: 50,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      })
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Complex Analysis",
                    "Complex numbers have many applications in math and physics",
                    Image.asset(
                      CustomIcons.complexAnalysis,
                      width: 57,
                      height: 70,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Complex Operations",
                          "Functionalities to add, substract and multiply complex numbers",
                          Image.asset(
                            CustomIcons.operations,
                            width: 25,
                            height: 30,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      mathTopicListile(
                          context,
                          "Polar Form",
                          "Provides the polar form of a given complex number",
                          Image.asset(
                            CustomIcons.polarForm,
                            width: 25,
                            height: 50,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      })
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Numerical Series",
                    "Handles sums and products of series as well as taylor expansion",
                    Image.asset(
                      CustomIcons.binomial,
                      width: 57,
                      height: 100,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Summations",
                          "Evaluates the convergence of series of summation of a given expression",
                          Image.asset(
                            CustomIcons.summation,
                            width: 25,
                            height: 30,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      mathTopicListile(
                          context,
                          "Products",
                          "Evaluates the convergence of series of multiplications of a given expression",
                          Image.asset(
                            CustomIcons.product,
                            width: 25,
                            height: 50,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(providers: [
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
                      mathTopicListile(
                          context,
                          "Taylor Series",
                          "Gives an approximation of a function up to the given order",
                          Image.asset(
                            CustomIcons.taylorSeries,
                            width: 25,
                            height: 400,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    ic<ExpandTaylorSeriesBloc>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<TaylorSeriesFieldsCubit>(),
                              ),
                            ],
                            child: const TaylorSeriesPage(),
                          ),
                        ));
                      })
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Limits",
                    "Calculates the value a function approximates to for a certain input",
                    Image.asset(
                      CustomIcons.limit,
                      width: 57,
                      height: 70,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Evaluate limits",
                          "Evaluate the limit of a function up to 3 dimensions",
                          Image.asset(
                            CustomIcons.limits,
                            width: 25,
                            height: 30,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                mathTopicExpander(
                    context,
                    "Linear Algebra",
                    "Studies the matrix representation of spaces and their applications",
                    Image.asset(
                      CustomIcons.algebra,
                      width: 57,
                      height: 40,
                      color: Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customWhite,
                    ),
                    [
                      mathTopicListile(
                          context,
                          "Matrix Operations",
                          "Provides useful functionalities to add and multiply matrixes ",
                          Image.asset(
                            CustomIcons.operations,
                            width: 25,
                            height: 30,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                      mathTopicListile(
                          context,
                          "Invert Matrix",
                          "Inverts the inputed matrix if it is invertible in record timing",
                          Image.asset(
                            CustomIcons.matrix,
                            width: 25,
                            height: 50,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                      mathTopicListile(
                          context,
                          "Matrix Rank",
                          "Calculates the rank of a given matrix promptly ",
                          Image.asset(
                            CustomIcons.rank,
                            width: 25,
                            height: 50,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
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
                      }),
                      mathTopicListile(
                          context,
                          "Determinant",
                          "Finds the value of the determinant of the given matrix ",
                          Image.asset(
                            CustomIcons.determinant,
                            width: 25,
                            height: 100,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      }),
                      mathTopicListile(
                          context,
                          "Eigen values and vectors",
                          "Finds the eigen value and vector of a given matrix",
                          Image.asset(
                            CustomIcons.eigen,
                            width: 25,
                            height: 100,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
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
                      mathTopicListile(
                          context,
                          "Linear Equations",
                          "Solves a linear equations by specifying the values that satisfy the linear system",
                          Image.asset(
                            CustomIcons.linearEquation,
                            width: 25,
                            height: 10,
                            color: Provider.of<ThemeManager>(context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlack
                                : AppColors.customWhite,
                          ), (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    ic<SolveLinearSystemBloc>(),
                              ),
                              BlocProvider(
                                create: (context) => ic<LinearSystemEquationsFieldsCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    ic<LinearSystemEquationsCubit>(),
                              ),
                            ],
                            child: const LinearEquationsPage(),
                          ),
                        ));
                      }),
                    ]),
              ],
            ),
            _learnMoreWidget(context)
          ],
        ));
  }

  Padding _learnMoreWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
      child: Center(
          child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColorTint50
                    : AppColors.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.customWhite,
                  ),
                ),
                Text(
                  "Learn more about how MathHelper works",
                  style: TextStyle(
                    color: AppColors.customWhite,
                    fontSize: 14,
                    fontFamily:
                        Theme.of(context).textTheme.labelMedium!.fontFamily,
                  ),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: AppColors.customWhite,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Container mathTopicExpander(BuildContext context, String title,
      String description, Widget topicIcon, List<ListTile> elements) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlackTint80
                    : AppColors.customBlackTint20,
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: MathematicalTopicWidget(
        title: title,
        description: description,
        topicIcon: topicIcon,
        collapsedIcon:
            Provider.of<ThemeManager>(context, listen: false).themeData ==
                    AppThemeData.lightTheme
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                  )
                : const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.customBlackTint80,
                  ),
        expandedIcon:
            Provider.of<ThemeManager>(context, listen: false).themeData ==
                    AppThemeData.lightTheme
                ? const Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.primaryColor,
                  )
                : const Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.customBlackTint80,
                  ),
        elementsCards: elements,
      ),
    );
  }

  ListTile mathTopicListile(BuildContext context, String title,
      String description, Widget icon, Function onTap) {
    return ListTile(
      onTap: () => onTap(context),
      leading: icon,
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint80,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle:
          Text(description, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
