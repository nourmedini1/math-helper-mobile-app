import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';

import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/presentation/bloc/function_plotting_bloc.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/axis_controls_widget.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_widget.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/plot_parameters.dart';
import 'package:provider/provider.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  double xMin = -10;
  double xMax = 10;
  double yMin = -2;
  double yMax = 2;

  late TextEditingController xMinController;
  late TextEditingController xMaxController;
  late TextEditingController yMinController;
  late TextEditingController yMaxController;
  late TextEditingController firstFunctionController;
  late TextEditingController secondFunctionController;

  @override
  void initState() {
    super.initState();
    xMinController = TextEditingController(text: xMin.toString());
    xMaxController = TextEditingController(text: xMax.toString());
    yMinController = TextEditingController(text: yMin.toString());
    yMaxController = TextEditingController(text: yMax.toString());
    firstFunctionController = TextEditingController(text: "sin(x)");
    secondFunctionController = TextEditingController(text: "cos(x)");
  }

  @override
  void dispose() {
    xMinController.dispose();
    xMaxController.dispose();
    yMinController.dispose();
    yMaxController.dispose();
    firstFunctionController.dispose();
    secondFunctionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<FunctionPlottingBloc, FunctionPlottingState>(
          listener: (context, state) {
            if (state is FunctionPlottingFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: AppColors.customWhite,
                    ),
                  ),
                  backgroundColor: AppColors.customRed,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is FunctionPlottingInitial) {
              return _graphInitialScreen();
            } else if (state is FunctionPlottingLoading) {
              return const LoadingScreen();
            } else if (state is FunctionPlottingSuccess) {
              PlotResponse response = state.plotResponse;
              if (response.isFirstPlot) {
                context.read<GraphCubit>().updateFirstGraph(
                      xValues: state.plotResponse.data.x,
                      yValues: state.plotResponse.data.y,
                      function: firstFunctionController.text,
                      variationTable: response.variationTable,
                    );
              } else {
                context.read<GraphCubit>().updateSecondGraph(
                      xValues: state.plotResponse.data.x,
                      yValues: state.plotResponse.data.y,
                      function: secondFunctionController.text,
                      variationTable: response.variationTable,
                    );
              }
            }
            return _graphInitialScreen();
          },
        ),
      ),
    );
  }

  Widget _graphInitialScreen() {
    return BlocBuilder<GraphCubit, GraphState>(
      builder: (context, state) {
        if (state is GraphInitial) {
          return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               GraphWidget(
                firstGraphData: state.firstGraphData,
                secondGraphData: state.secondGraphData,
               ),
              const SizedBox(height: 16),
              AxisControls(
                  xMinController: xMinController,
                  xMaxController: xMaxController,
                  yMinController: yMinController,
                  yMaxController: yMaxController),
              const SizedBox(height: 16),
              PlotParametersWidget(
                isFirstPlot: true,
                graphData: state.firstGraphData,
                functionController: firstFunctionController,
              ),
              const SizedBox(height: 16),
              PlotParametersWidget(
                  isFirstPlot: false,
                  graphData: state.secondGraphData,
                  functionController: secondFunctionController)
            ],
          ),
        );
        } else {
          return const Center(child: CircularProgressIndicator());
          }
        
      },
    );
  }
}
