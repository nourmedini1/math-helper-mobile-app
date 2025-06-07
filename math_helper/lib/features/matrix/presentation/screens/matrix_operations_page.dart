import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/custom_rect_tween.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/hero_dialog_route.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:provider/provider.dart';

class MatrixOperationsPage extends StatefulWidget {
  const MatrixOperationsPage({super.key});

  @override
  State<MatrixOperationsPage> createState() => _MatrixOperationsPageState();
}

class _MatrixOperationsPageState extends State<MatrixOperationsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController additonFirstRowsController;
  late TextEditingController additionFirstColumnsController;

  late TextEditingController additionSecondRowsController;
  late TextEditingController additionSecondColumnsController;

  late List<TextEditingController> additionFirstControllers;
  late List<TextEditingController> additionSecondControllers;

  late TextEditingController multiplicationFirstRowsController;
  late TextEditingController multiplicationFirstColumnsController;
  late TextEditingController multiplicationSecondRowsController;
  late TextEditingController multiplicationSecondColumnsController;
  late List<TextEditingController> multiplicationFirstControllers;
  late List<TextEditingController> multiplicationSecondControllers;

  bool additionFirstMatrixReady = false;
  bool additionSecondMatrixReady = false;

  bool multiplicationFirstMatrixReady = false;
  bool multiplicationSecondMatrixReady = false;

  bool isAdditionFirstMatrixGenerated = false;
  bool isAdditionSecondMatrixGenerated = false;
  bool isMultiplicationFirstMatrixGenerated = false;
  bool isMultiplicationSecondMatrixGenerated = false;

  List<TextEditingController> additionFirstMatrixControllers = [];
  List<TextEditingController> additionSecondMatrixControllers = [];
  List<TextEditingController> multiplicationFirstMatrixControllers = [];
  List<TextEditingController> multiplicationSecondMatrixControllers = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    additonFirstRowsController = TextEditingController();
    additionFirstColumnsController = TextEditingController();
    additionSecondRowsController = TextEditingController();
    additionSecondColumnsController = TextEditingController();

    multiplicationFirstRowsController = TextEditingController();
    multiplicationFirstColumnsController = TextEditingController();
    multiplicationSecondRowsController = TextEditingController();
    multiplicationSecondColumnsController = TextEditingController();

    additionFirstControllers = [
      additonFirstRowsController,
      additionFirstColumnsController
    ];
    additionSecondControllers = [
      additionSecondRowsController,
      additionSecondColumnsController
    ];

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in additionFirstControllers) {
      controller.dispose();
    }
    for (var controller in additionSecondControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            context: context,
            tabController: tabController,
            hasTabBar: true,
            appBarBottom: appBarBottom(context),
            hasHomeIcon: true),
        drawer: const CustomDrawer(),
        body: TabBarView(controller: tabController, children: [
          Center(child: additionScreen(context)),
          Center(
            child: multiplicationScreen(context),
          )
        ]));
  }

  Widget additionScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<AddMatrixBloc, AddMatrixState>(
        listener: (context, state) {
          if (state is AddMatrixFailure) {
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
          if (state is AddMatrixInitial) {
            return additionInitialWidget(context);
          } else if (state is AddMatrixLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is AddMatrixSuccess) {
            return successWidget(
                context,
                "Matrix Addition",
                state.response.matrix!,
                "add",
                state.response.matrixA!,
                state.response.matrixB!);
          } else if (state is AddMatrixFailure) {
            return additionInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget multiplicationScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<MultiplyMatrixBloc, MultiplyMatrixState>(
        listener: (context, state) {
          if (state is MultiplyMatrixFailure) {
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
          if (state is MultiplyMatrixInitial) {
            return multiplicationInitialWidget(context);
          } else if (state is MultiplyMatrixLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is MultiplyMatrixSuccess) {
            return successWidget(
                context,
                "Matrix Multiplication",
                state.response.matrix!,
                "multiply",
                state.response.matrixA!,
                state.response.matrixB!);
          } else if (state is MultiplyMatrixFailure) {
            return multiplicationInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget additionInitialWidget(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Matrix Addition",
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
                          child: inputTitle(context, "The first matrix"),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: textField(
                                    context,
                                    additonFirstRowsController,
                                    "Rows",
                                    "add",
                                    0,
                                    150),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: textField(
                                    context,
                                    additionFirstColumnsController,
                                    "Columns",
                                    "add",
                                    0,
                                    150),
                              ),
                            ],
                          ),
                          generateMatrixButton(
                              true,
                              true,
                              context,
                              additionFirstMatrixControllers,
                              updateAdditionFirstMatrixGenerated,
                              int.tryParse(additonFirstRowsController.text) ??
                                  4,
                              int.tryParse(
                                      additionFirstColumnsController.text) ??
                                  4,
                              !isAdditionFirstMatrixGenerated),
                        ],
                      ),
                    ],
                  )))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: inputTitle(context, "The second matrix"),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(context, additionSecondRowsController,
                          "Rows", "add", 1, 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(context, additionSecondColumnsController,
                          "Columns", "add", 1, 150),
                    ),
                  ],
                ),
                generateMatrixButton(
                    false,
                    true,
                    context,
                    additionSecondMatrixControllers,
                    updateAdditionSecondMatrixGenerated,
                    int.tryParse(additionSecondRowsController.text) ?? 4,
                    int.tryParse(additionSecondColumnsController.text) ?? 4,
                    !isAdditionSecondMatrixGenerated),
              ],
            ),
          ),
        ),
      ),
      submitButton(
          context,
          "add",
          additionFirstMatrixReady && additionSecondMatrixReady,
          additionFirstMatrixControllers,
          additionSecondMatrixControllers),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: clearButton(
            context,
            additionFirstMatrixControllers,
            additionSecondMatrixControllers,
            additonFirstRowsController,
            additionFirstColumnsController,
            additionSecondRowsController,
            additionSecondColumnsController,
            "add"),
      )
    ]);
  }

  Widget multiplicationInitialWidget(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Matrix Multiplication",
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
                          child: inputTitle(context, "The first matrix"),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: textField(
                                    context,
                                    multiplicationFirstRowsController,
                                    "Rows",
                                    "multiply",
                                    0,
                                    150),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: textField(
                                    context,
                                    multiplicationFirstColumnsController,
                                    "Columns",
                                    "multiply",
                                    0,
                                    150),
                              ),
                            ],
                          ),
                          generateMatrixButton(
                              true,
                              true,
                              context,
                              multiplicationFirstMatrixControllers,
                              updateMultiplicationFirstMatrixGenerated,
                              int.tryParse(
                                      multiplicationFirstRowsController.text) ??
                                  4,
                              int.tryParse(multiplicationFirstColumnsController
                                      .text) ??
                                  4,
                              !isMultiplicationFirstMatrixGenerated),
                        ],
                      ),
                    ],
                  )))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: inputTitle(context, "The second matrix"),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          multiplicationSecondRowsController,
                          "Rows",
                          "multiply",
                          1,
                          150),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          multiplicationSecondColumnsController,
                          "Columns",
                          "multiply",
                          1,
                          150),
                    ),
                  ],
                ),
                generateMatrixButton(
                    false,
                    true,
                    context,
                    multiplicationSecondMatrixControllers,
                    updateMultiplicationSecondMatrixGenerated,
                    int.tryParse(multiplicationSecondRowsController.text) ?? 4,
                    int.tryParse(multiplicationSecondColumnsController.text) ??
                        4,
                    !isMultiplicationSecondMatrixGenerated),
              ],
            ),
          ),
        ),
      ),
      submitButton(
          context,
          "multiply",
          multiplicationFirstMatrixReady && multiplicationSecondMatrixReady,
          multiplicationFirstMatrixControllers,
          multiplicationSecondMatrixControllers),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: clearButton(
            context,
            multiplicationFirstMatrixControllers,
            multiplicationSecondMatrixControllers,
            multiplicationFirstRowsController,
            multiplicationFirstColumnsController,
            multiplicationSecondRowsController,
            multiplicationSecondColumnsController,
            "multiply"),
      )
    ]);
  }

  Widget matrixResult(BuildContext context, String matrix, String title,
      String matrixA, String matrixB) {
    return Column(
      children: [
        Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
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
                    context, "result", r"""$$""" + matrixA + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                    context, "result", r"""$$""" + matrixB + r"""$$"""))),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              title,
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
                    context, "result", r"""$$""" + matrix + r"""$$"""))),
      ],
    );
  }

  Widget successWidget(BuildContext context, String title, String matrix,
      String operation, String matrixA, String matrixB) {
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
                    matrixResult(
                        context, matrix, "The matrix result", matrixA, matrixB),
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
            child: matrixResetButton(context, operation),
          ),
        ],
      ),
    );
  }

  void updateAdditionFirstMatrixGenerated(
      bool isClearing, List<TextEditingController> controllers) {
    if (isClearing) {
      for (var controller in controllers) {
        controller.clear();
      }
      setState(() {
        isAdditionFirstMatrixGenerated = false;
      });
    } else {
      setState(() {
        isAdditionFirstMatrixGenerated = true;
      });
    }
  }

  void updateAdditionSecondMatrixGenerated(
      bool isClearing, List<TextEditingController> controllers) {
    if (isClearing) {
      for (var controller in controllers) {
        controller.clear();
      }
      setState(() {
        isAdditionSecondMatrixGenerated = false;
      });
    } else {
      setState(() {
        isAdditionSecondMatrixGenerated = true;
      });
    }
  }

  void updateMultiplicationFirstMatrixGenerated(
      bool isClearing, List<TextEditingController> controllers) {
    if (isClearing) {
      for (var controller in controllers) {
        controller.clear();
      }
      setState(() {
        isMultiplicationFirstMatrixGenerated = false;
      });
    } else {
      setState(() {
        isMultiplicationFirstMatrixGenerated = true;
      });
    }
  }

  void updateMultiplicationSecondMatrixGenerated(
      bool isClearing, List<TextEditingController> controllers) {
    if (isClearing) {
      for (var controller in controllers) {
        controller.clear();
      }
      setState(() {
        isMultiplicationSecondMatrixGenerated = false;
      });
    } else {
      setState(() {
        isMultiplicationSecondMatrixGenerated = true;
      });
    }
  }

  Widget submitButton(
      BuildContext context,
      String operation,
      bool isFieldsReady,
      List<TextEditingController> firstMatrixControllers,
      List<TextEditingController> secondMatrixControllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  if (operation == "add") {
                    int rows1 = int.parse(additonFirstRowsController.text);
                    int columns1 =
                        int.parse(additionFirstColumnsController.text);
                    int rows2 = int.parse(additionSecondRowsController.text);
                    int columns2 =
                        int.parse(additionSecondColumnsController.text);
                    if (rows1 != rows2 || columns1 != columns2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "The matrices must have the same size",
                            style: TextStyle(
                              color: AppColors.customWhite,
                            ),
                          ),
                          backgroundColor: AppColors.customRed,
                        ),
                      );
                      return;
                    }

                    MatrixRequest request = parseRequest(
                        rows1,
                        columns1,
                        rows2,
                        columns2,
                        firstMatrixControllers,
                        secondMatrixControllers);

                    BlocProvider.of<AddMatrixBloc>(context)
                        .add(AddMatrixRequested(request: request));
                  } else {
                    int rows1 =
                        int.parse(multiplicationFirstRowsController.text);
                    int columns1 =
                        int.parse(multiplicationFirstColumnsController.text);
                    int rows2 =
                        int.parse(multiplicationSecondRowsController.text);
                    int columns2 =
                        int.parse(multiplicationSecondColumnsController.text);

                    if (columns1 != rows2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "The matrices do not have matching sizes to be multiplied",
                            style: TextStyle(
                              color: AppColors.customWhite,
                            ),
                          ),
                          backgroundColor: AppColors.customRed,
                        ),
                      );
                      return;
                    }
                    MatrixRequest request = parseRequest(
                        rows1,
                        columns1,
                        rows2,
                        columns2,
                        firstMatrixControllers,
                        secondMatrixControllers);

                    BlocProvider.of<MultiplyMatrixBloc>(context)
                        .add(MultiplyMatrixRequested(request: request));
                  }
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

  Widget matrixResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "add") {
          BlocProvider.of<AddMatrixBloc>(context).add(const AddMatrixReset());
        } else {
          BlocProvider.of<MultiplyMatrixBloc>(context)
              .add(const MultiplyMatrixReset());
        }
      },
      child: resetButton(context),
    );
  }

  Widget clearButton(
      BuildContext context,
      List<TextEditingController> firstMatrixControllers,
      List<TextEditingController> secondMatrixControllers,
      TextEditingController firstRowsController,
      TextEditingController firstColumnsController,
      TextEditingController secondRowsController,
      TextEditingController secondColumnsController,
      String operation) {
    return GestureDetector(
      onTap: () {
        firstMatrixControllers.addAll(secondMatrixControllers);
        firstMatrixControllers.add(firstRowsController);
        firstMatrixControllers.add(firstColumnsController);
        firstMatrixControllers.add(secondRowsController);
        firstMatrixControllers.add(secondColumnsController);

        for (var element in firstMatrixControllers) {
          element.clear();
        }
        if (operation == "add") {
          setState(() {
            additionFirstMatrixReady = false;
            additionSecondMatrixReady = false;
            isAdditionFirstMatrixGenerated = false;
            isAdditionSecondMatrixGenerated = false;
          });
        } else {
          setState(() {
            multiplicationFirstMatrixReady = false;
            multiplicationSecondMatrixReady = false;
            isMultiplicationFirstMatrixGenerated = false;
            isMultiplicationSecondMatrixGenerated = false;
          });
        }
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget matrixClearButton(BuildContext context,
      List<TextEditingController> controllers, String operation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: () {
            for (var element in controllers) {
              element.clear();
            }
            if (operation == "add") {
              setState(() {
                additionFirstMatrixReady = false;
                additionSecondMatrixReady = false;
              });
            } else {
              setState(() {
                multiplicationFirstMatrixReady = false;
                multiplicationSecondMatrixReady = false;
              });
            }
          },
          child: clearButtonDecoration(context),
        ),
      ),
    );
  }

  Widget generateMatrixButton(
      bool isFirstMatrix,
      bool isMatrixAddition,
      BuildContext context,
      List<TextEditingController> controllers,
      Function(bool, List<TextEditingController>) updateFunction,
      int rows,
      int columns,
      bool isGenerating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (isGenerating) {
              controllers.clear();
              for (var i = 0; i < columns; i++) {
                for (var j = 0; j < rows; j++) {
                  controllers.add(TextEditingController());
                }
              }
            }
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return MatrixInputPopup(
                  controllers: controllers,
                  updateVariable: updateFunction,
                  tag: isFirstMatrix ? "First Matrix" : "Second Matrix",
                  rows: rows > 5 ? 5 : rows,
                  columns: columns > 5 ? 5 : columns,
                  title: isMatrixAddition
                      ? "Matrix Addition"
                      : "Matrix Multiplication");
            }));
          },
          child: Hero(
            tag: isFirstMatrix ? "First Matrix" : "Second Matrix",
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
                      isGenerating ? "Generate" : "Check matrix",
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

  dynamic parseValue(String input) {
    double? tryDouble = double.tryParse(input);
    if (tryDouble != null) {
      return tryDouble;
    }

    return 0;
  }

  MatrixRequest parseRequest(
    int rows1,
    int columns1,
    int rows2,
    int columns2,
    List<TextEditingController> controllersA,
    List<TextEditingController> controllersB,
  ) {
    List<List<double>> matrixA = [];
    List<List<double>> matrixB = [];

    for (var controller in controllersA) {
      print(controller.text);
    }
    print("\n");
    for (var controller in controllersB) {
      print(controller.text);
    }
    for (var i = 0; i < columns1; i++) {
      List<double> tmp = [];
      for (var j = 0; j < rows1; j++) {
        tmp.add(parseValue(controllersA[columns1 * i + j].text));
      }
      matrixA.add(tmp);
    }
    for (var i = 0; i < columns2; i++) {
      List<double> tmp = [];
      for (var j = 0; j < rows2; j++) {
        tmp.add(parseValue(controllersB[columns2 * i + j].text));
      }
      matrixB.add(tmp);
    }
    return MatrixRequest(matrixA: matrixA, matrixB: matrixB);
  }

  Widget textField(
    BuildContext context,
    TextEditingController controller,
    String hint,
    String operation,
    int matrix,
    double width,
  ) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (operation == "add") {
              if (matrix == 0) {
                setState(() {
                  isAdditionFirstMatrixGenerated = false;
                });
                if (additonFirstRowsController.text.isNotEmpty &&
                    additionFirstColumnsController.text.isNotEmpty) {
                  setState(() {
                    additionFirstMatrixReady = true;
                  });
                } else {
                  setState(() {
                    additionFirstMatrixReady = false;
                  });
                }
              } else {
                setState(() {
                  isAdditionSecondMatrixGenerated = false;
                });
                if (additionSecondRowsController.text.isNotEmpty &&
                    additionSecondColumnsController.text.isNotEmpty) {
                  setState(() {
                    additionSecondMatrixReady = true;
                  });
                } else {
                  setState(() {
                    additionSecondMatrixReady = false;
                  });
                }
              }
            } else {
              if (matrix == 0) {
                setState(() {
                  isMultiplicationFirstMatrixGenerated = false;
                });
                if (multiplicationFirstRowsController.text.isNotEmpty &&
                    multiplicationFirstColumnsController.text.isNotEmpty) {
                  setState(() {
                    multiplicationFirstMatrixReady = true;
                  });
                } else {
                  setState(() {
                    multiplicationFirstMatrixReady = false;
                  });
                }
              } else {
                setState(() {
                  isMultiplicationSecondMatrixGenerated = false;
                });
                if (multiplicationSecondRowsController.text.isNotEmpty &&
                    multiplicationSecondColumnsController.text.isNotEmpty) {
                  setState(() {
                    multiplicationSecondMatrixReady = true;
                  });
                } else {
                  setState(() {
                    multiplicationSecondMatrixReady = false;
                  });
                }
              }
            }
          },
          controller: controller,
          keyboardType: TextInputType.number,
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

  PreferredSize appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Column(
        children: [
          Divider(
            height: 1,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColorTint50
                    : AppColors.customBlackTint60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Provider.of<ThemeManager>(context).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint90
                      : AppColors.customDarkGrey,
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: AppColors.primaryColorTint50,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: AppColors.customWhite,
                  unselectedLabelColor:
                      Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customBlackTint90,
                  tabs: const [
                    TabBarItem(
                      title: ' Add',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Multiply',
                        icon: Icon(Icons.bar_chart, size: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  loadingComponent(BuildContext context) {}
  
  resetButton(BuildContext context) {}
  
  inputTitle(BuildContext context, String s) {}
}

class MatrixInputPopup extends StatefulWidget {
  final Function(bool, List<TextEditingController>) updateVariable;
  final String tag;
  final List<TextEditingController> controllers;
  final int rows;
  final int columns;
  final String title;

  const MatrixInputPopup({
    super.key,
    required this.controllers,
    required this.updateVariable,
    required this.tag,
    required this.rows,
    required this.columns,
    required this.title,
  });

  @override
  State<MatrixInputPopup> createState() => _MatrixInputPopupState();
}

class _MatrixInputPopupState extends State<MatrixInputPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Hero(
          tag: widget.tag,
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
                        widget.title,
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
                      inputTitle(context, widget.tag),
                      Center(
                        child: SizedBox(
                          height: 400,
                          child: GridView.builder(
                            padding: EdgeInsets.all(100 / widget.columns),
                            shrinkWrap: true,
                            itemCount: widget.rows * widget.columns,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: widget.columns),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: textFieldDecoration(context),
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    onChanged: (value) {
                                      widget.updateVariable(
                                          false, widget.controllers);
                                    },
                                    controller: widget.controllers[index],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .fontFamily,
                                          color: AppColors.customBlackTint60,
                                          fontSize: 12),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
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
                            widget.updateVariable(true, widget.controllers);
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
  
  inputTitle(BuildContext context, String tag) {}
}
