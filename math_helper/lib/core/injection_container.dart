import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
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
import 'package:math_helper/features/derivatives/data/api/derivatives_api.dart';
import 'package:math_helper/features/derivatives/data/repository/derivatives_repository_impl.dart';
import 'package:math_helper/features/derivatives/domain/repository/derivatives_repository.dart';
import 'package:math_helper/features/derivatives/domain/usecases/numeric_derivative_usecase.dart';
import 'package:math_helper/features/derivatives/domain/usecases/symbolic_derivative_usecase.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/differential_equations/data/api/differential_equations_api.dart';
import 'package:math_helper/features/differential_equations/data/repository/differential_equations_repository_impl.dart';
import 'package:math_helper/features/differential_equations/domain/repository/differential_equations_repository.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/first_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/second_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/third_order_differential_equation_usecase.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/integrals/data/api/integrals_api.dart';
import 'package:math_helper/features/integrals/data/repository/integrals_repository_impl.dart';
import 'package:math_helper/features/integrals/domain/repository/integrals_repository.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_integral_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_integral_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_primitive_usecase.dart';
import 'package:math_helper/features/integrals/domain/usecases/triple_integral_usecase.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';

final ic = GetIt.instance;

Future<void> init() async {
  //!core
  ic.registerLazySingleton(() => Connectivity());
  ic.registerLazySingleton(() => http.Client());

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

  // integrals
  ic.registerLazySingleton(() => IntegralsApi(client: ic()));
  ic.registerLazySingleton<IntegralsRepository>(
      () => IntegralsRepositoryImpl(connectivity: ic(), integralsApi: ic()));

  ic.registerLazySingleton(
      () => SinglePrimitiveUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => DoubleIntegralUsecase(integralsRepository: ic()));
  ic.registerLazySingleton(
      () => TripleIntegralUsecase(integralsRepository: ic()));
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
      thirdOrderDifferentialEquationUsecasese: ic()));
}
