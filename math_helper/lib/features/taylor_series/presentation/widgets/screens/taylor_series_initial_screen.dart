import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/cubit/taylor_series/taylor_series_fields_cubit.dart';
import 'package:provider/provider.dart';

class TaylorSeriesInitialScreen extends StatefulWidget {

  final TextEditingController expressionController;
  final TextEditingController variableController;
  final TextEditingController orderController;
  final TextEditingController nearController;

  const TaylorSeriesInitialScreen({super.key, 
  required this.expressionController, 
  required this.variableController, 
  required this.orderController, 
  required this.nearController});

  @override
  State<TaylorSeriesInitialScreen> createState() => _TaylorSeriesInitialScreenState();
}

class _TaylorSeriesInitialScreenState extends State<TaylorSeriesInitialScreen> {
  @override
  Widget build(BuildContext context) {
     List<TextEditingController> controllers = [
      widget.expressionController,
      widget.variableController,
      widget.orderController,
      widget.nearController
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: InputContainer(
        
        title: "Taylor Series", 
        body: buildBody(controllers), 
        submitButton: buildSubmitButton(),
        clearButton: ClearButton(
          onPressed: () => handleClearButtonPressed(controllers),
        ),
        ),
    );
  }


  BlocBuilder buildSubmitButton() {
    return BlocBuilder<TaylorSeriesFieldsCubit, TaylorSeriesFieldsState>(
      builder: (context, state) {
        if (state is TaylorSeriesFieldsMissing) {
          return SubmitButton(
            color: AppColors.customBlackTint80,
            onPressed: () {},
          );
        } else if (state is TaylorSeriesFieldsReady) {
          return SubmitButton(
            color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                ? AppColors.primaryColorTint50
                : AppColors.primaryColor,
            onPressed: () => handleSubmitButtonPressed(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildBody(List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            label: "The expression",
            hint: "Example: cos(x)", 
            controller: widget.expressionController, 
            onChanged: (value) => handleInputChange(
            controllers)),
          CustomTextField(
            label: "The variable",
            hint: "The variable used, example: x",
            controller: widget.variableController,
            onChanged: (value) => handleInputChange(
             controllers),
          ),
          CustomTextField(
            label: "The order of the expansion",
            hint: "Must be 1 or greater",
            keyboardType: TextInputType.number,
            controller: widget.orderController,
            onChanged: (value) => handleInputChange(
             controllers),
          ),
          CustomTextField(
            label: "The point of expansion",
            hint: "Expand the expression near...",
            keyboardType: TextInputType.number,
            controller: widget.nearController,
            onChanged: (value) => handleInputChange(
             controllers),
          ),
        ],
      
      ),
    );
  }


  void handleSubmitButtonPressed() {
    final TaylorSeriesRequest request = TaylorSeriesRequest(
      expression: widget.expressionController.text,
      variable: widget.variableController.text,
      order: int.tryParse(widget.orderController.text) ?? 1,
      near: double.tryParse(widget.nearController.text) ?? 0.0,
    );
    BlocProvider.of<ExpandTaylorSeriesBloc>(context).add(ExpandTaylorSeriesRequested(request: request));
  }

  void handleClearButtonPressed(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
    context.read<TaylorSeriesFieldsCubit>().checkFieldsReady(false);
  }

  void handleInputChange(List<TextEditingController> controllers) {
    final allFilled = controllers.every((c) => c.text.isNotEmpty);
    context.read<TaylorSeriesFieldsCubit>().checkFieldsReady(allFilled);
  }




}