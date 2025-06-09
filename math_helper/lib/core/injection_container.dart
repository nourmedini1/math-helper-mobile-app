import 'package:archive/archive.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/ui/cubits/search/search_cubit.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/api/complex_api.dart';
import 'package:math_helper/features/complex/data/repository/complex_repository_impl.dart';
import 'package:math_helper/features/complex/domain/repository/complex_repository.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_addition_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_multiplication_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_substraction_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/polar_form_usecase.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/cubit/addition_cubit/addition_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/multiplication_cubit/multiplication_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/polar_form_cubit/polar_form_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/substraction_cubit/substraction_cubit.dart';
import 'package:math_helper/features/derivatives/data/api/derivatives_api.dart';
import 'package:math_helper/features/derivatives/data/repository/derivatives_repository_impl.dart';
import 'package:math_helper/features/derivatives/domain/repository/derivatives_repository.dart';
import 'package:math_helper/features/derivatives/domain/usecases/numeric_derivative_usecase.dart';
import 'package:math_helper/features/derivatives/domain/usecases/symbolic_derivative_usecase.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_derivative_fields/numeric_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_partial_derivative/numeric_partial_derivative_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_derivative_fields/symbolic_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_partial_derivative/symbolic_partial_derivative_cubit.dart';
import 'package:math_helper/features/differential_equations/data/api/differential_equations_api.dart';
import 'package:math_helper/features/differential_equations/data/repository/differential_equations_repository_impl.dart';
import 'package:math_helper/features/differential_equations/domain/repository/differential_equations_repository.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/first_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/second_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/third_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/first_order_coefficients/first_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/first_order_constraints/first_order_constraints_text_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_coefficients/second_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_constraints/second_order_constraints_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/third_order_coefficents/third_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/third_order_constraints/third_order_constraints_cubit.dart';
import 'package:math_helper/features/function_plotting/data/api/function_plotting_api.dart';
import 'package:math_helper/features/function_plotting/data/repository/function_plotting_repository.dart';
import 'package:math_helper/features/function_plotting/domain/repository/function_plotting_repository.dart';
import 'package:math_helper/features/function_plotting/domain/usecases/function_plotting_usecase.dart';
import 'package:math_helper/features/function_plotting/presentation/function_plotting_bloc/function_plotting_bloc.dart';
import 'package:math_helper/features/integrals/data/api/integrals_api.dart';
import 'package:math_helper/features/integrals/data/repository/integrals_repository_impl.dart';
import 'package:math_helper/features/integrals/domain/repository/integrals_repository.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_integral_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_primitive_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_integral_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_primitive_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/triple_integral_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/triple_primitive_usecase.dart';
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
import 'package:math_helper/features/limits/data/api/limits_api.dart';
import 'package:math_helper/features/limits/data/repository/limits_repository_impl.dart';
import 'package:math_helper/features/limits/domain/repository/limits_repository.dart';
import 'package:math_helper/features/limits/domain/usecases/double_limit_usecase.dart';
import 'package:math_helper/features/limits/domain/usecases/single_limit_usecase.dart';
import 'package:math_helper/features/limits/domain/usecases/triple_limit_usecase.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/linear_systems/data/api/linear_systems_api.dart';
import 'package:math_helper/features/linear_systems/data/repository/linear_systems_repository_impl.dart';
import 'package:math_helper/features/linear_systems/domain/repository/linear_systems_repository.dart';
import 'package:math_helper/features/linear_systems/domain/usecases/solve_linear_system_usecase.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/matrix/data/api/matrix_api.dart';
import 'package:math_helper/features/matrix/data/repository/matrix_repository_impl.dart';
import 'package:math_helper/features/matrix/domain/repository/matrix_repository.dart';
import 'package:math_helper/features/matrix/domain/usecases/add_matrix_usecase.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_determinant_usecase.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_eigen_usecase.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_rank_usecase.dart';
import 'package:math_helper/features/matrix/domain/usecases/invert_matrix_usecase.dart';
import 'package:math_helper/features/matrix/domain/usecases/multiply_matrix_usecase.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/invert_matrix/invert_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:math_helper/features/product/data/api/product_api.dart';
import 'package:math_helper/features/product/data/repository/product_repository_impl.dart';
import 'package:math_helper/features/product/domain/repository/product_repository.dart';
import 'package:math_helper/features/product/domain/usecases/numeric_product_usecase.dart';
import 'package:math_helper/features/product/domain/usecases/symbolic_product_usecase.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/sum/data/api/sum_api.dart';
import 'package:math_helper/features/sum/data/repository/sum_repository_impl.dart';
import 'package:math_helper/features/sum/domain/repository/sum_repository.dart';
import 'package:math_helper/features/sum/domain/usecases/numeric_sum_usecase.dart';
import 'package:math_helper/features/sum/domain/usecases/symbolic_sum_usecase.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/taylor_series/data/api/taylor_series_api.dart';
import 'package:math_helper/features/taylor_series/data/repository/taylor_series_repository_impl.dart';
import 'package:math_helper/features/taylor_series/domain/repository/taylor_series_repository.dart';
import 'package:math_helper/features/taylor_series/domain/usecases/expand_taylor_series_usecase.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/cubit/taylor_series/taylor_series_fields_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ic = GetIt.instance;

Future<void> init() async {
  //!core
  ic.registerLazySingleton(() => Connectivity());
  ic.registerLazySingleton(() => http.Client());
  ic.registerLazySingleton(() => const ZLibDecoder());
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  ic.registerLazySingleton(() => sharedPreferences);
  ic.registerLazySingleton(() => LocalStorageService(sharedPreferences: ic()));
  ic.registerFactory(() => SearchCubit());
  ic.registerLazySingleton(() => ThemeManager());

  //!features

  // complex
  ic.registerLazySingleton(() => ComplexApi(client: ic()));
  ic.registerLazySingleton<ComplexRepository>(
      () => ComplexRepositoryImpl(connectivity: ic(), complexApi: ic()));

  ic.registerLazySingleton(
      () => ComplexAdditionUsecase(complexRepository: ic()));
  ic.registerLazySingleton(
      () => ComplexMultiplicationUsecase(complexRepository: ic()));
  ic.registerLazySingleton(
      () => ComplexSubstractionUsecase(complexRepository: ic()));
  ic.registerLazySingleton(() => PolarFormUsecase(complexRepository: ic()));

  ic.registerFactory(() => ComplexAdditionBloc(complexAdditionUsecase: ic()));
  ic.registerFactory(
      () => ComplexSubstractionBloc(complexSubstractionUsecase: ic()));
  ic.registerFactory(
      () => ComplexMultiplicationBloc(complexMultiplicationUsecase: ic()));
  ic.registerFactory(() => PolarFormBloc(polarFormUsecase: ic()));

  ic.registerFactory(() => AdditionCubit());
  ic.registerFactory(() => SubstractionCubit());
  ic.registerFactory(() => MultiplicationCubit());
  ic.registerFactory(() => PolarFormCubit());



  // derivatives
  ic.registerLazySingleton(() => DerivativesApi(client: ic()));
  ic.registerLazySingleton<DerivativesRepository>(() =>
      DerivativesRepositoryImpl(connectivity: ic(), derivativesApi: ic()));

  ic.registerLazySingleton(
      () => SymbolicDerivativeUsecase(derivativesRepository: ic()));
  ic.registerLazySingleton(
      () => NumericDerivativeUsecase(derivativesRepository: ic()));

  ic.registerFactory(
      () => SymbolicDerivativeBloc(symbolicDerivativeUsecase: ic()));
  ic.registerFactory(
      () => NumericDerivativeBloc(numericDerivativeUsecase: ic()));
  ic.registerFactory(() => SymbolicDerivativeFieldsCubit());
  ic.registerFactory(() => NumericDerivativeFieldsCubit());
  ic.registerFactory(() => SymbolicPartialDerivativeCubit());
  ic.registerFactory(() => NumericPartialDerivativeCubit());

  // integrals
  ic.registerLazySingleton(() => IntegralsApi(client: ic()));
  ic.registerLazySingleton<IntegralsRepository>(
      () => IntegralsRepositoryImpl(connectivity: ic(), integralsApi: ic()));

  ic.registerLazySingleton(
      () => SinglePrimitiveUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => DoublePrimitiveUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => TriplePrimitiveUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => SingleIntegralUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => DoubleIntegralUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => TripleIntegralUsecase(integralsRepository: ic()));

  ic.registerFactory(() => SingleIntegralBloc(singleIntegralUsecase: ic()));
  ic.registerFactory(() => DoubleIntegralBloc(doubleIntegralUsecase: ic()));
  ic.registerFactory(() => TripleIntegralBloc(tripleIntegralUsecase: ic()));
  ic.registerFactory(() => SinglePrimitiveBloc(singlePrimitiveUsecase: ic()));
  ic.registerFactory(() => DoublePrimitiveBloc(doublePrimitiveUsecase: ic()));
  ic.registerFactory(() => TriplePrimitiveBloc(triplePrimitiveUsecase: ic()));
  ic.registerFactory(() => SingleDefiniteIntegralLimitsTextCubit());
  ic.registerFactory(() =>DoubleDefiniteIntegralLimitsTextCubit());
  ic.registerFactory(() => TripleDefiniteIntegralLimitTextCubit());
  ic.registerFactory(() => SingleFieldsCubit());
  ic.registerFactory(() => DoubleFieldsCubit());
  ic.registerFactory(() => TripleFieldsCubit());
  ic.registerFactory(() => IndefiniteSingleFieldsCubit());
  ic.registerFactory(() => IndefiniteDoubleFieldsCubit());
  ic.registerFactory(() => IndefiniteTripleFieldsCubit());


  //  differential equations
  ic.registerLazySingleton(() => DifferentialEquationsApi(client: ic()));
  ic.registerLazySingleton<DifferentialEquationsRepository>(() =>
      DifferentialEquationsRepositoryImpl(
          connectivity: ic(), differentialEquationsApi: ic()));

  ic.registerLazySingleton(() => FirstOrderDifferentialEquationUsecase(
      differentialEquationsRepository: ic()));
  ic.registerLazySingleton(() => SecondOrderDifferentialEquationUsecase(
      differentialEquationsRepository: ic()));
  ic.registerLazySingleton(() => ThirdOrderDifferentialEquationUsecase(
      differentialEquationsRepository: ic()));

  ic.registerFactory(() => FirstOrderDifferentialEquationBloc(
      firstOrderDifferentialEquationUsecase: ic()));
  ic.registerFactory(() => SecondOrderDifferentialEquationBloc(
      secondOrderDifferentialEquationUsecase: ic()));
  ic.registerFactory(() => ThirdOrderDifferentialEquationBloc(
      thirdOrderDifferentialEquationUsecase: ic()));
  ic.registerFactory(() => FirstOrderCoefficientsCubit());
  ic.registerFactory(() => ThirdOrderCoefficientsCubit());
  ic.registerFactory(() => SecondOrderCoefficientsCubit());
  ic.registerFactory(() => FirstOrderConstraintsTextCubit());
  ic.registerFactory(() => SecondOrderConstraintsCubit());
  ic.registerFactory(() => ThirdOrderConstraintsCubit());

  // limits
  ic.registerLazySingleton(() => LimitsApi(client: ic()));
  ic.registerLazySingleton<LimitsRepository>(
      () => LimitsRepositoryImpl(connectivity: ic(), limitsApi: ic()));
  ic.registerLazySingleton(() => SingleLimitUsecase(limitsRepository: ic()));
  ic.registerLazySingleton(() => DoubleLimitUsecase(limitsRepository: ic()));
  ic.registerLazySingleton(() => TripleLimitUsecase(limitsRepository: ic()));

  ic.registerFactory(() => SingleLimitBloc(singleLimitUsecase: ic()));
  ic.registerFactory(() => DoubleLimitBloc(doubleLimitUsecase: ic()));
  ic.registerFactory(() => TripleLimitBloc(tripleLimitUsecase: ic()));

  // products
  ic.registerLazySingleton(() => ProductApi(client: ic()));
  ic.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(connectivity: ic(), productApi: ic()));

  ic.registerLazySingleton(() => SymbolicProductUsecase(repository: ic()));
  ic.registerLazySingleton(() => NumericProductUsecase(repository: ic()));

  ic.registerFactory(() => SymbolicProductBloc(symbolicProductUsecase: ic()));
  ic.registerFactory(() => NumericProductBloc(numericProductUsecase: ic()));

  // sum
  ic.registerLazySingleton(() => SumApi(client: ic()));
  ic.registerLazySingleton<SumRepository>(
      () => SumRepositoryImpl(connectivity: ic(), sumApi: ic()));

  ic.registerLazySingleton(() => SymbolicSumUsecase(repository: ic()));
  ic.registerLazySingleton(() => NumericSumUsecase(repository: ic()));

  ic.registerFactory(() => SymbolicSumBloc(symbolicSumUsecase: ic()));
  ic.registerFactory(() => NumericSumBloc(numericSumUsecase: ic()));

  // taylor series
  ic.registerLazySingleton(() => TaylorSeriesApi(client: ic()));
  ic.registerLazySingleton<TaylorSeriesRepository>(() =>
      TaylorSeriesRepositoryImpl(connectivity: ic(), taylorSeriesApi: ic()));

  ic.registerLazySingleton(
      () => ExpandTaylorSeriesUsecase(taylorSeriesRepository: ic()));
  ic.registerFactory(() => ExpandTaylorSeriesBloc(taylorSeriesUsecase: ic()));
  ic.registerFactory(() => TaylorSeriesFieldsCubit());

  // linear systems
  ic.registerLazySingleton(() => LinearSystemsApi(client: ic()));
  ic.registerLazySingleton<LinearSystemsRepository>(() =>
      LinearSystemsRepositoryImpl(connectivity: ic(), linearSystemsApi: ic()));
  ic.registerLazySingleton(() => SolveLinearSystemUsecase(repository: ic()));

  ic.registerFactory(
      () => SolveLinearSystemBloc(solveLinearSystemUsecase: ic()));

  // matrix operations
  ic.registerLazySingleton(() => MatrixApi(client: ic()));

  ic.registerLazySingleton<MatrixRepository>(
      () => MatrixRepositoryImpl(connectivity: ic(), matrixApi: ic()));
  ic.registerLazySingleton(() => AddMatrixUsecase(repository: ic()));
  ic.registerLazySingleton(() => MultiplyMatrixUsecase(repository: ic()));
  ic.registerLazySingleton(() => GetEigenUsecase(repository: ic()));
  ic.registerLazySingleton(() => GetDeterminantUsecase(repository: ic()));
  ic.registerLazySingleton(() => GetRankUsecase(repository: ic()));
  ic.registerLazySingleton(() => InvertMatrixUsecase(repository: ic()));

  ic.registerFactory(() => AddMatrixBloc(addMatrixUsecase: ic()));
  ic.registerFactory(() => MultiplyMatrixBloc(multiplyMatrixUsecase: ic()));
  ic.registerFactory(() => EigenBloc(getEigenUsecase: ic()));
  ic.registerFactory(() => DeterminantBloc(getDeterminantUsecase: ic()));
  ic.registerFactory(() => RankBloc(getRankUsecase: ic()));
  ic.registerFactory(() => InvertMatrixBloc(invertMatrixUsecase: ic()));

  // function plotting 
  ic.registerLazySingleton(() => FunctionPlottingApi(client: ic(), zlibDecoder: ic()));

  ic.registerLazySingleton<FunctionPlottingRepository>(
    () => FunctionPlottingRepositoryImpl(connectivity: ic(), functionPlottingApi: ic()));
  ic.registerLazySingleton(() => FunctionPlottingUsecase(functionPlottingRepository: ic()));

  ic.registerFactory(() => FunctionPlottingBloc(functionPlottingUsecase: ic()));
}
