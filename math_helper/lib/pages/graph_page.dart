import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/components/variation_table_screen.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/components/custom_graph.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/presentation/function_plotting_bloc/function_plotting_bloc.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../core/ui/components/expandable_widget.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  late Map<String, dynamic> firstPlot;
  late Map<String, dynamic> secondPlot;
  bool isFirstPlotReady = false;
  bool isSecondPlotReady = false;
  Color firstSelectedColor = AppColors.primaryColorShade40;
  Color secondSelectedColor = AppColors.secondaryColorShade40;

  double xMin = -10;
  double xMax = 10;
  double yMin = -2;
  double yMax = 2;

  final sinVariationTable = const VariationTable(
    intervals: [[0, "pi/2"], ["pi/2", 0]],
    values: [[0, 1], [1, 0]],
    directions: ["increasing", "decreasing"],
    firstDerivativeSign: ["+", "-"],
    secondDerivativeSign: ["-", "+"],
  );

  final cosVariationTable = const VariationTable(
    intervals: [[0, "pi/2"], ["pi/2", 0]],
    values: [[0, 1], [1, 0]],
    directions: ["decreasing", "increasing"],
    firstDerivativeSign: ["-", "+"],
    secondDerivativeSign: ["+", "-"],
  );

  late TextEditingController xMinController;
  late TextEditingController xMaxController;
  late TextEditingController yMinController;
  late TextEditingController yMaxController;

  @override
  void initState() {
    super.initState();
    firstPlot = _initializePlot(true);
    secondPlot = _initializePlot(false);

    // Example data for demonstration
List<double> xVals = List.generate(100, (i) => -10 + i * 20 / 99);
List<double> yVals = xVals.map((x) => sin(x)).toList();
firstPlot["plotData"] = Plot(
  function: 'sin(x)',
  xValues: xVals,
  yValues: yVals,
  color: AppColors.primaryColorShade10,
  label: 'sin(x)',
  variationTable: sinVariationTable,
  
);

List<double> xVals2 = List.generate(100, (i) => -10 + i * 20 / 99);
List<double> yVals2 = xVals2.map((x) => cos(x)).toList();
secondPlot["plotData"] = Plot(
  function: 'cos(x)',
  xValues: xVals2,
  yValues: yVals2,
  color: AppColors.secondaryColorShade30,
  label: 'cos(x)',
  isVisible: false,
  variationTable: cosVariationTable,
);

    xMinController = TextEditingController(text: xMin.toString());
    xMaxController = TextEditingController(text: xMax.toString());
    yMinController = TextEditingController(text: yMin.toString());
    yMaxController = TextEditingController(text: yMax.toString());
  }

  @override
  void dispose() {
    xMinController.dispose();
    xMaxController.dispose();
    yMinController.dispose();
    yMaxController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _initializePlot(bool isFirstPlot) {
    return {
      "strokeWidth": 2.0,
      "functionController": isFirstPlot
          ? TextEditingController(text: "sin(x)")
          : TextEditingController(text: "cos(x)"),
      "plotData": Plot(
        function: '',
        xValues: [],
        yValues: [],
        color: isFirstPlot
            ? AppColors.primaryColorShade40
            : AppColors.secondaryColorShade40,
        label: '',
      ),
    };
  }




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ic<FunctionPlottingBloc>(),
      child: Scaffold(
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
                return loadingComponent(context);
              } else if (state is FunctionPlottingSuccess) {
  PlotResponse response = state.plotResponse;
  if (response.isFirstPlot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final plotData = state.plotResponse.data;
        final oldPlot = firstPlot["plotData"] as Plot;
        firstPlot["plotData"] = Plot(
          function: firstPlot["functionController"].text,
          xValues: plotData.x,
          yValues: plotData.y,
          label: firstPlot["functionController"].text,
          color: oldPlot.color,
          isVisible: oldPlot.isVisible,
          strokeWidth: oldPlot.strokeWidth,
          dotSize: oldPlot.dotSize,
          showDots: oldPlot.showDots,
          isCurved: oldPlot.isCurved,
          showArea: oldPlot.showArea,
          areaColor: oldPlot.areaColor,
          topTitle: oldPlot.topTitle,
          leftTitle: oldPlot.leftTitle,
          rightTitle: oldPlot.rightTitle,
          variationTable: response.variationTable,
        );
      });
      
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final plotData = state.plotResponse.data;
        final oldPlot = secondPlot["plotData"] as Plot;
        secondPlot["plotData"] = Plot(
          function: secondPlot["functionController"].text,
          xValues: plotData.x,
          yValues: plotData.y,
          label: secondPlot["functionController"].text,
          color: oldPlot.color,
          isVisible: oldPlot.isVisible,
          strokeWidth: oldPlot.strokeWidth,
          dotSize: oldPlot.dotSize,
          showDots: oldPlot.showDots,
          isCurved: oldPlot.isCurved,
          showArea: oldPlot.showArea,
          areaColor: oldPlot.areaColor,
          topTitle: oldPlot.topTitle,
          leftTitle: oldPlot.leftTitle,
          rightTitle: oldPlot.rightTitle,
          variationTable: response.variationTable,
        );
      });
      
    });
  }
}
              return _graphInitialScreen();
            },
          ),
        ),
      ),
    );
  }

  Widget _graphInitialScreen() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChart(),
          const SizedBox(height: 16),
          _buildAxisControls(),
          const SizedBox(height: 16),
          plotParameters(true, firstPlot),
          const SizedBox(height: 16),
          plotParameters(false, secondPlot),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Center(
          child: CustomGraph(
  x1: firstPlot["plotData"].xValues,
  y1: firstPlot["plotData"].yValues,
  x2: secondPlot["plotData"].xValues,
  y2: secondPlot["plotData"].yValues,
  showFirst: firstPlot["plotData"].isVisible,
  showSecond: secondPlot["plotData"].isVisible,
  color1: firstPlot["plotData"].color,
  color2: secondPlot["plotData"].color,
  strokeWidth1: firstPlot["plotData"].strokeWidth,
  strokeWidth2: secondPlot["plotData"].strokeWidth,
  showDots1: firstPlot["plotData"].showDots,
  showDots2: secondPlot["plotData"].showDots,
  showArea1: firstPlot["plotData"].showArea,
  showArea2: secondPlot["plotData"].showArea,
  areaColor1: firstPlot["plotData"].areaColor ?? AppColors.primaryColorShade20.withOpacity(0.2),
  areaColor2: secondPlot["plotData"].areaColor ?? AppColors.secondaryColorShade20.withOpacity(0.2),
  xMin: xMin,
  xMax: xMax,
  yMin: yMin,
  yMax: yMax,
  functionName1: firstPlot["functionController"].text,
  functionName2: secondPlot["functionController"].text,
)
        ),
      ),
    );
  }

  Widget _buildAxisControls() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _axisColumn(
            "X Min: ", xMinController, "0", (value) {
              setState(() {
                xMin = double.tryParse(value) ?? 0;
              });
            },
            "X Max:", xMaxController, "20", (value) {
              setState(() {
                xMax = double.tryParse(value) ?? 20;
              });
            },
          ),
          _axisColumn(
            "Y Min: ", yMinController, "-2", (value) {
              setState(() {
                yMin = double.tryParse(value) ?? -2;
              });
            },
            "Y Max:", yMaxController, "2", (value) {
              setState(() {
                yMax = double.tryParse(value) ?? 2;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _axisColumn(
    String minLabel,
    TextEditingController minController,
    String minHint,
    ValueChanged<String> minOnChanged,
    String maxLabel,
    TextEditingController maxController,
    String maxHint,
    ValueChanged<String> maxOnChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            inputTitle(context, minLabel),
            const SizedBox(width: 8),
            textField(
              context,
              minController,
              minHint,
              true,
              true,
              80,
              onChangedOverride: minOnChanged,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            inputTitle(context, maxLabel),
            const SizedBox(width: 8),
            textField(
              context,
              maxController,
              maxHint,
              true,
              true,
              80,
              onChangedOverride: maxOnChanged,
            ),
          ],
        ),
      ],
    );
  }

  
  // --- Plot Parameters Widget (unchanged, modular) ---
  ExpandableGroup plotParameters(bool isFirstplot, Map<String, dynamic> plot) {
    return ExpandableGroup(
      isExpanded: false,
      headerBackgroundColor: Provider.of<ThemeManager>(context, listen: false)
                  .themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
      header: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(Icons.settings,
                color: Provider.of<ThemeManager>(context, listen: false)
                        .themeData ==
                    AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customBlackTint80),
            const SizedBox(width: 8),
            inputTitle(context, isFirstplot ? "First Plot Parameters" : "Second Plot Parameters"),
          ],
        ),
      ),
      items: [
        ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: inputTitle(context, "The expression"),
          ),
          subtitle: textField(context, plot["functionController"], "example: sin(x)", true, false ,100),
          tileColor: Provider.of<ThemeManager>(context, listen: false)
                  .themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
          
        ),
        ListTile(
          tileColor: Provider.of<ThemeManager>(context, listen: false)
                  .themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
  title: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          final functionText = plot["functionController"].text;
          final isPeriodic = _isPeriodic(functionText);
          final VariationTable? table = plot["plotData"].variationTable;

          if (table != null) {
            if (isPeriodic &&
                table.intervals!.length > 1 &&
                table.values!.length > 1 &&
                table.directions!.length > 1 &&
                table.firstDerivativeSign!.length > 1 &&
                table.secondDerivativeSign!.length > 1) {
              final periodTable = plot["functionController"].text.contains('sin')
                  ? sinVariationTable
                  : cosVariationTable;
            showVariationTableModal(context, periodTable);
            } else {
             showVariationTableModal(context, table);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No variation table available for this function.")),
            );
          }
        },
        child: const Center(
          child: Text(
            "Show Variation Table",
            style: TextStyle(
              color: AppColors.customWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  ),
),
        
       ListTile(
        tileColor: Provider.of<ThemeManager>(context, listen: false)
                  .themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
          
          title: ExpandableGroup(
            isExpanded: false,
      headerBackgroundColor: Provider.of<ThemeManager>(context, listen: false)
                  .themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlackTint80.withOpacity(0)
          : AppColors.customBlackTint20,
            header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: inputTitle(context, "Plot Appearance"),
          ), items: [
            SwitchListTile(
    title: Padding(
      padding: const EdgeInsets.only(top: 18, left: 8.0, right: 8.0, bottom: 8.0),
      child: inputTitle(context, "Show Plot"),
    ),
    value: plot["plotData"].isVisible,
    onChanged: (value) {
      setState(() {
        plot["plotData"].isVisible = value;
      });
    },
    activeColor: AppColors.primaryColor,
    tileColor: Provider.of<ThemeManager>(context, listen: false).themeData ==
        AppThemeData.lightTheme
        ? AppColors.customBlackTint80.withOpacity(0)
        : AppColors.customBlackTint20,
),
             ListTile(
              
            title: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: inputTitle(context, "Color"),   
              
            ),
            subtitle: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      title: inputTitle(context, "Select the graph color"),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: isFirstplot
                              ? firstSelectedColor
                              : secondSelectedColor,
                          onColorChanged: (color) {
                            setState(() {
                              if (isFirstplot) {
                                firstSelectedColor = color;
                              } else {
                                secondSelectedColor = color;
                              }
                              plot["plotData"].color = color;
                            });
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: inputTitle(
                            context,
                            "Close",
                          )
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: isFirstplot
                      ? firstSelectedColor
                      : secondSelectedColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            tileColor: Provider.of<ThemeManager>(context, listen: false)
                    .themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlackTint80.withOpacity(0)
            : AppColors.customBlackTint20,
          ),
           SwitchListTile(
  title: Padding(
    padding: const EdgeInsets.only(top: 18, left: 8.0, right: 8.0, bottom: 8.0),
    child: inputTitle(context, "Show Dots"),
  ),
  value: plot["plotData"].showDots,
  onChanged: (value) {
    setState(() {
      plot["plotData"].showDots = value;
    });
  },
  activeColor: AppColors.primaryColor,
  tileColor: Provider.of<ThemeManager>(context, listen: false).themeData ==
      AppThemeData.lightTheme
      ? AppColors.customBlackTint80.withOpacity(0)
      : AppColors.customBlackTint20,
),
          
         
ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: inputTitle(context, "Stroke Width"),
            ),
            subtitle: Slider(
              value: plot["plotData"].strokeWidth,
              min: 1.0,
              max: 10.0,
              divisions: 9,
              label: plot["plotData"].strokeWidth.toString(),
              onChanged: (value) {
                setState(() {
                  plot["plotData"].strokeWidth = value;
                });
              },
                activeColor: AppColors.primaryColor, // Main color for the slider
    inactiveColor: AppColors.customWhite, // Track color for inactive part
    thumbColor: AppColors.primaryColorShade10,
            ),
            tileColor: Provider.of<ThemeManager>(context, listen: false)
                    .themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlackTint80.withOpacity(0)
            : AppColors.customBlackTint20,
          ),
          
          SwitchListTile(
  title: Padding(
    padding: const EdgeInsets.all(8.0),
    child: inputTitle(context, "Show Area"),
  ),
  value: plot["plotData"].showArea,
  onChanged: (value) {
    setState(() {
      plot["plotData"].showArea = value;
    });
  },
  activeColor: AppColors.primaryColor,
  tileColor: Provider.of<ThemeManager>(context, listen: false).themeData ==
      AppThemeData.lightTheme
      ? AppColors.customBlackTint80.withOpacity(0)
      : AppColors.customBlackTint20,
),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: inputTitle(context, "Area Color"),
            ),
            subtitle: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      title: inputTitle(context, "Select the area color"),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: plot["plotData"].areaColor ?? isFirstplot
                              ? firstSelectedColor.withOpacity(0.2)
                              : secondSelectedColor.withOpacity(0.2),
                          onColorChanged: (color) {
                            setState(() {
                              plot["plotData"].areaColor = color.withOpacity(0.2);
                            });
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: inputTitle(
                            context,
                            "Close",
                          )
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: plot["plotData"].areaColor ?? AppColors.secondaryColorShade10.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            tileColor: Provider.of<ThemeManager>(context, listen: false)
                    .themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlackTint80.withOpacity(0)
            : AppColors.customBlackTint20,
          ),

         
          
            ])
          ),
          
         
          ListTile(
             tileColor: Provider.of<ThemeManager>(context, listen: false)
                    .themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlackTint80.withOpacity(0.2)
            : AppColors.customBlackTint20,
            shape: const RoundedRectangleBorder(
               borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
            title: SizedBox(
              width: double.infinity,
              child: submitButton(context, plot["functionController"].text.isNotEmpty,isFirstplot  )
            ),
          ),

        ],
      );
  }



  Widget textField(
      BuildContext context,
      TextEditingController controller,
      String hint,
      bool isFirstPlot,
      bool isNumberField,
      double width, {
    void Function(String)? onChangedOverride,
  }) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (onChangedOverride != null) {
              onChangedOverride(value);
            } else {
              if (isFirstPlot) {
                setState(() {
                  isFirstPlotReady = firstPlot["functionController"].text.isNotEmpty;
                });
              } else {
                setState(() {
                  isSecondPlotReady = secondPlot["functionController"].text.isNotEmpty;
                });
              }
            }
          },
          controller: controller,
          keyboardType: isNumberField ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumberField
              ? [FilteringTextInputFormatter.allow(RegExp(r'^[0-9.-]+$'))]
              : [FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9\s\+\-\*\/\(\)\^\.]+$')),
          ],
          textInputAction: TextInputAction.next,
          maxLines: 1,
          cursorColor:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColor
                  : AppColors.customWhite,
          cursorWidth: 0.8,
          style: TextStyle(
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily),
          textAlign: TextAlign.start,
          decoration: textFieldInputDecoration(context, hint)),
    );
  }

  bool _isPeriodic(String function) {
    final f = function.toLowerCase();
    return f.contains('sin') || f.contains('cos') || f.contains('tan');
  }

  void showVariationTableModal(BuildContext context, VariationTable table) {
  showModalBottomSheet(

    context: context,
    backgroundColor: Provider.of<ThemeManager>(context, listen: false)
        .themeData == AppThemeData.lightTheme
        ? AppColors.customWhite
        : AppColors.customBlackTint20,
        
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16,),
          inputTitle(context, "Variation Table"),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: CustomPaint(
              painter: VariationTablePainter(table, context),
            ),
          ),
         
        ],
      ),
    ),
  );
}



  

  

  Widget submitButton(
      BuildContext context, bool isFieldsReady, bool isFirstPlot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
      child: Builder(
        builder: (ctx) => GestureDetector(
          onTap: () {
            final functionText = firstPlot["functionController"].text.trim();
            if (functionText.isEmpty) return;

            final plotRequest = PlotRequest(
              function: functionText,
              precision: _isPeriodic(functionText) ? 5000 : 1500,
              lowerBound: -1000,
              upperBound: 1000,
              maxPoints: 1000,
              isFirstPlot: isFirstPlot,
            );

            ctx.read<FunctionPlottingBloc>().add(
              PlotFunctionRequested(request: plotRequest),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isFieldsReady
                    ? AppColors.primaryColorTint50
                    : AppColors.customBlackTint80),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.done_outline_outlined,
                      color: AppColors.customWhite,
                    ),
                  ),
                  Text(
                    "Plot Graph",
                    style: TextStyle(
                      color: AppColors.customWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          Theme.of(context).textTheme.labelMedium!.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
  
  inputTitle(BuildContext context, String s) {}
  
  Widget loadingComponent(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.primaryColor
              : AppColors.customWhite,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
  
}



class Plot {
  String function;
  List<double> xValues;
  List<double> yValues;
  Color color;
  String label;
  bool isVisible;
  double strokeWidth;
  double dotSize;
  bool showDots;
  bool isCurved;
  bool showArea;
  Color? areaColor;
  String? topTitle;
  String? leftTitle;
  String? rightTitle;
  VariationTable? variationTable;

  Plot({
    required this.function,
    required this.xValues,
    required this.yValues,
    this.color = AppColors.primaryColorShade40,
    this.label = '',
    this.isVisible = true,
    this.strokeWidth = 3.0,
    this.dotSize = 4.0,
    this.showDots = false,
    this.isCurved = true,
    this.showArea = false,
    this.areaColor,
    this.topTitle,
    this.leftTitle,
    this.rightTitle,
    this.variationTable,
  });
}



