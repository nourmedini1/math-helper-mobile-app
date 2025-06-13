import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/function_plotting/presentation/bloc/function_plotting_bloc.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/first_graph_fields/first_graph_fields_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/second_graph_fields/second_graph_fields_cubit.dart';
import 'package:math_helper/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ic<FunctionPlottingBloc>()),
        BlocProvider(create: (context) => ic<GraphCubit>()),
        BlocProvider(create: (context) => ic<FirstGraphFieldsCubit>()),
        BlocProvider(create: (context) => ic<SecondGraphFieldsCubit>()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ic<ThemeManager>()..init(),
        child: Consumer<ThemeManager>(
          builder: (context, ThemeManager themeManager, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
              theme: themeManager.themeData,
            );
          },
        ),
      ),
    ),
  );
}
