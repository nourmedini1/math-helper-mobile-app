import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/custom_rect_tween.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/hero_dialog_route.dart';
import 'package:math_helper/core/ui/components/input_title.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:provider/provider.dart';

class LinearEquationsPage extends StatefulWidget {
  const LinearEquationsPage({super.key});

  @override
  State<LinearEquationsPage> createState() => _LinearEquationsPageState();
}

class _LinearEquationsPageState extends State<LinearEquationsPage> {
  late TextEditingController numberOfEquationsController;
  late TextEditingController variablesController;

  bool isEquationsReady = false;

  bool isEquationsGenerated = false;

  List<TextEditingController> equationsControllers = [];
  List<TextEditingController> secondHnadSidesControllers = [];

  @override
  void initState() {
    numberOfEquationsController = TextEditingController();
    variablesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberOfEquationsController.dispose();
    variablesController.dispose();
    for (var controller in equationsControllers) {
      controller.dispose();
    }
    for (var controller in secondHnadSidesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context,
          tabController: null,
          hasTabBar: false,
          appBarBottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Divider(
              height: 1,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.customBlackTint60,
            ),
          ),
          hasHomeIcon: true),
      drawer: const CustomDrawer(),
      body: Center(
        child: linearEquationsScreen(context),
      ),
    );
  }

  Widget linearEquationsScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SolveLinearSystemBloc, SolveLinearSystemState>(
        listener: (context, state) {
          if (state is SolveLinearSystemFailure) {
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
          if (state is SolveLinearSystemInitial) {
            return linearEquationsInitialWidget(context);
          } else if (state is SolveLinearSystemLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SolveLinearSystemSuccess) {
            return successWidget(
              context,
              "Linear Equations",
              state.response.linearSystem,
              state.response.result!,
            );
          } else if (state is SolveLinearSystemFailure) {
            return linearEquationsInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget linearEquationsInitialWidget(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Linear Equations",
          style: TextStyle(
              color: AppColors.primaryColorTint50,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint60
                      : AppColors.customBlackTint90, // Border color
                  width: 0.5, // Border width
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0), // Border radius
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: inputTitle(context, "The linear system"),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: textField(
                                context,
                                numberOfEquationsController,
                                "Number of equations, default 3",
                                TextInputType.number),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: textField(
                                context,
                                variablesController,
                                "Used variables, default: x,y,z",
                                TextInputType.text),
                          ),
                          generateEquationsButton(
                              context,
                              equationsControllers,
                              secondHnadSidesControllers,
                              updateEquationsGenerated,
                              int.tryParse(numberOfEquationsController.text) ??
                                  3,
                              !isEquationsGenerated),
                        ],
                      ),
                    ],
                  )))),
      submitButton(context, isEquationsReady, equationsControllers,
          secondHnadSidesControllers),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: clearButton(
          context,
          equationsControllers,
          secondHnadSidesControllers,
          numberOfEquationsController,
          variablesController,
        ),
      )
    ]);
  }

  Widget successWidget(
      BuildContext context, String title, String linearSystem, String result) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.primaryColorTint50,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.customBlackTint60
                        : AppColors.customBlackTint90, // Border color
                    width: 0.5, // Border width
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0), // Border radius
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    linearEquationsResult(
                      context,
                      linearSystem,
                      result,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: linearEquationsResetButton(context),
          ),
        ],
      ),
    );
  }

  Widget linearEquationsResult(
      BuildContext context, String linearSystem, String result) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              "The linear system",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                color: Provider.of<ThemeManager>(context).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                style: const TeXViewStyle(textAlign: TeXViewTextAlign.left),
                loadingWidgetBuilder: (context) => Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Provider.of<ThemeManager>(context, listen: false)
                                    .themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.primaryColor
                            : AppColors.customBlackTint60,
                      ),
                    ),
                child: teXViewWidget(
                    context, "result", r"""$$""" + linearSystem + r"""$$"""))),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              "The result",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                color: Provider.of<ThemeManager>(context).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                style: const TeXViewStyle(textAlign: TeXViewTextAlign.left),
                loadingWidgetBuilder: (context) => Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Provider.of<ThemeManager>(context, listen: false)
                                    .themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.primaryColor
                            : AppColors.customBlackTint60,
                      ),
                    ),
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget submitButton(
    BuildContext context,
    bool isFieldsReady,
    List<TextEditingController> equationControllers,
    List<TextEditingController> rightHandSideControllers,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  LinearSystemRequest request = parseRequest(
                    int.parse(numberOfEquationsController.text),
                    rightHandSideControllers,
                    equationControllers,
                  );
                  BlocProvider.of<SolveLinearSystemBloc>(context)
                      .add(SolveLinearSystemRequested(request: request));
                }
              : () {},
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
                    "Get results",
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
    );
  }

  Widget linearEquationsResetButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SolveLinearSystemBloc>(context)
            .add(const SolveLinearSystemReset());
      },
      child: resetButton(context),
    );
  }

  Widget clearButton(
    BuildContext context,
    List<TextEditingController> equationControllers,
    List<TextEditingController> rightHandSideControllers,
    TextEditingController numberOfEquationsController,
    TextEditingController variablesController,
  ) {
    return GestureDetector(
      onTap: () {
        for (var i = 0; i < equationsControllers.length; i++) {
          equationsControllers[i].clear();
          rightHandSideControllers[i].clear();
        }
        numberOfEquationsController.clear();
        variablesController.clear();

        setState(() {
          isEquationsReady = false;
          isEquationsGenerated = false;
        });
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget linearSystemClearButton(
      BuildContext context,
      List<TextEditingController> equationControllers,
      List<TextEditingController> rightHandSideControllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: () {
            for (var i = 0; i < equationsControllers.length; i++) {
              equationsControllers[i].clear();
              rightHandSideControllers[i].clear();
            }

            setState(() {
              isEquationsGenerated = false;
            });
          },
          child: clearButtonDecoration(context),
        ),
      ),
    );
  }

  Widget generateEquationsButton(
      BuildContext context,
      List<TextEditingController> equationsControllers,
      List<TextEditingController> rightHandSideControllers,
      Function(bool, List<TextEditingController>, List<TextEditingController>)
          updateFunction,
      int numberOfEquations,
      bool isGenerating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (numberOfEquationsController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please enter the number of equations",
                    style: TextStyle(
                      color: AppColors.customWhite,
                    ),
                  ),
                  backgroundColor: AppColors.customRed,
                ),
              );
              return;
            }
            if (isGenerating) {
              equationsControllers.clear();
              rightHandSideControllers.clear();
              for (var i = 0; i < numberOfEquations; i++) {
                equationsControllers.add(TextEditingController());
                rightHandSideControllers.add(TextEditingController());
              }
            }
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return LinearSystemPopup(
                rightHandSideControllers: rightHandSideControllers,
                equationControllers: equationsControllers,
                updateVariable: updateFunction,
              );
            }));
          },
          child: Hero(
            tag: "Linear System",
            child: Material(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isGenerating
                        ? AppColors.primaryColorTint50
                        : AppColors.secondaryColor),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      isGenerating ? "Generate" : "Check equations",
                      style: TextStyle(
                        color: AppColors.customWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            Theme.of(context).textTheme.labelMedium!.fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateEquationsGenerated(
      bool isClearing,
      List<TextEditingController> equationsControllers,
      List<TextEditingController> rightHandSide) {
    if (isClearing) {
      for (var i = 0; i < equationsControllers.length; i++) {
        equationsControllers[i].clear();
        rightHandSide[i].clear();
      }
      setState(() {
        isEquationsGenerated = false;
      });
    } else {
      setState(() {
        isEquationsGenerated = true;
      });
    }
  }

  LinearSystemRequest parseRequest(
    int numberOfEquations,
    List<TextEditingController> rightHandSideControllers,
    List<TextEditingController> equationControllers,
  ) {
    List<String> equations = [];
    List<Object> rightHandSide = [];
    List<String> variables = [];
    variables = variablesController.text.isNotEmpty
        ? variablesController.text.split(",")
        : ["x", "y", "z"];

    for (var i = 0; i < numberOfEquations; i++) {
      print(equationControllers[i].text);
      print(rightHandSideControllers[i].text);

      equations.add(equationControllers[i].text);
      rightHandSide.add(secondHnadSidesControllers[i].text);
    }

    return LinearSystemRequest(
        equations: equations,
        variables: variables,
        rightHandSide: rightHandSide);
  }

  Widget textField(BuildContext context, TextEditingController controller,
      String hint, TextInputType inputType) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            setState(() {
              isEquationsGenerated = false;
            });
            if (numberOfEquationsController.text.isNotEmpty) {
              setState(() {
                isEquationsReady = true;
              });
            } else {
              setState(() {
                isEquationsReady = false;
              });
            }
          },
          controller: controller,
          keyboardType: inputType,
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
}

class LinearSystemPopup extends StatefulWidget {
  final Function(bool, List<TextEditingController>, List<TextEditingController>)
      updateVariable;
  final List<TextEditingController> equationControllers;
  final List<TextEditingController> rightHandSideControllers;
  const LinearSystemPopup({
    super.key,
    required this.equationControllers,
    required this.updateVariable,
    required this.rightHandSideControllers,
  });

  @override
  State<LinearSystemPopup> createState() => _LinearSystemPopupState();
}

class _LinearSystemPopupState extends State<LinearSystemPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Hero(
          tag: "Linear System",
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Theme.of(context).colorScheme.background,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "Linear Equations",
                        style: TextStyle(
                            color: AppColors.primaryColorTint50,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontFamily),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      inputTitle(context, "Linear system of equations"),
                      Center(
                        child: SizedBox(
                          height: 400,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            shrinkWrap: true,
                            itemCount: widget.equationControllers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    textField(
                                        context,
                                        widget.equationControllers[index],
                                        "Example : 2x + y - z",
                                        200),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "=",
                                      style: TextStyle(
                                          color: AppColors.primaryColorTint50,
                                          fontSize: 20,
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontFamily),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    textField(
                                        context,
                                        widget.rightHandSideControllers[index],
                                        "",
                                        50)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? const EdgeInsets.only(left: 40, right: 40)
                            : const EdgeInsets.only(left: 200, right: 200),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColorTint50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: AppColors.customWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? const EdgeInsets.only(
                                top: 10, left: 40, right: 40)
                            : const EdgeInsets.only(
                                top: 10, left: 200, right: 200),
                        child: GestureDetector(
                          onTap: () {
                            widget.updateVariable(
                                true,
                                widget.equationControllers,
                                widget.rightHandSideControllers);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.secondaryColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Center(
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    color: AppColors.customWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(BuildContext context, TextEditingController controller,
      String hint, double width) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            widget.updateVariable(false, widget.equationControllers,
                widget.rightHandSideControllers);
          },
          controller: controller,
          keyboardType: TextInputType.text,
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
}
