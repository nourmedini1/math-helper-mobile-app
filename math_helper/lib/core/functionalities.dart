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
import 'package:math_helper/features/complex/presentation/screens/complex_operation_page.dart';
import 'package:math_helper/features/complex/presentation/screens/complex_polar_form_page.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/screens/derivatives_page.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/screens/differential_equations_page.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/screens/definite_integral_page.dart';
import 'package:math_helper/features/integrals/presentation/screens/indefinite_integral_page.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/screens/limits_page.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/screens/linear_equations_page.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/invert_matrix/invert_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:math_helper/features/matrix/presentation/screens/determinant_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/eigen_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/invert_matrix_page.dart';
import 'package:math_helper/features/matrix/presentation/screens/matrix_rank_page.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/screens/product_page.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/screens/sum_page.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/screens/taylor_series_page.dart';
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
                create: (context) => ic<FirstOrderDifferentialEquationBloc>(),
              ),
              BlocProvider(
                create: (context) => ic<SecondOrderDifferentialEquationBloc>(),
              ),
              BlocProvider(
                create: (context) => ic<ThirdOrderDifferentialEquationBloc>(),
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
            builder: (context) => BlocProvider(
              create: (context) => ic<InvertMatrixBloc>(),
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
            builder: (context) => BlocProvider(
              create: (context) => ic<DeterminantBloc>(),
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
            builder: (context) => BlocProvider(
              create: (context) => ic<RankBloc>(),
              child: const MatrixRankPage(),
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
              builder: (context) => BlocProvider(
                create: (context) => ic<EigenBloc>(),
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
              builder: (context) => BlocProvider(
                create: (context) {
                  return ic<PolarFormBloc>();
                },
                child: const ComplexPolarFormPage(),
              ),
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
              builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) => ic<SymbolicProductBloc>(),
                ),
                BlocProvider(
                  create: (context) => ic<NumericProductBloc>(),
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
              builder: (context) => BlocProvider(
                create: (context) => ic<ExpandTaylorSeriesBloc>(),
                child: const TaylorSeriesPage(),
              ),
            ));
          }),
    };
  }
}
