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
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:provider/provider.dart';

class MatrixRankPage extends StatefulWidget {
  const MatrixRankPage({super.key});

  @override
  State<MatrixRankPage> createState() => _MatrixRankPageState();
}

class _MatrixRankPageState extends State<MatrixRankPage> {
  late TextEditingController rowsController;
  late TextEditingController columnsController;

  bool isMatrixReady = false;

  bool isMatrixGenerated = false;

  List<TextEditingController> matrixControllers = [];

  @override
  void initState() {
    rowsController = TextEditingController();
    columnsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    rowsController.dispose();
    columnsController.dispose();
    for (var controller in matrixControllers) {
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
        child: rankScreen(context),
      ),
    );
  }

  Widget rankScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<RankBloc, RankState>(
        listener: (context, state) {
          if (state is RankFailure) {
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
          if (state is RankInitial) {
            return rankInitialWidget(context);
          } else if (state is RankLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is RankSuccess) {
            return successWidget(context, "Matrix Rank", state.response.rank!,
                state.response.matrixA!);
          } else if (state is RankFailure) {
            return rankInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  void updateMatrixGenerated(
      bool isClearing, List<TextEditingController> controllers) {
    if (isClearing) {
      for (var controller in controllers) {
        controller.clear();
      }
      setState(() {
        isMatrixGenerated = false;
      });
    } else {
      setState(() {
        isMatrixGenerated = true;
      });
    }
  }

  Widget rankInitialWidget(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Matrix Rank",
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
                          child: inputTitle(context, "The input matrix"),
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
                                    context, rowsController, "Rows", 150),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: textField(
                                    context, columnsController, "Columns", 150),
                              ),
                            ],
                          ),
                          generateMatrixButton(
                              context,
                              matrixControllers,
                              updateMatrixGenerated,
                              int.tryParse(rowsController.text) ?? 4,
                              int.tryParse(columnsController.text) ?? 4,
                              !isMatrixGenerated),
                        ],
                      ),
                    ],
                  )))),
      submitButton(
        context,
        isMatrixReady,
        matrixControllers,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: clearButton(
          context,
          matrixControllers,
          rowsController,
          columnsController,
        ),
      )
    ]);
  }

  Widget successWidget(
      BuildContext context, String title, String result, String matrix) {
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
                    matrixResult(context, result, "The matrix rank", matrix),
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
            child: matrixResetButton(context),
          ),
        ],
      ),
    );
  }

  Widget matrixResult(
      BuildContext context, String result, String title, String matrix) {
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
                    context, "result", r"""$$""" + matrix + r"""$$"""))),
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
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget submitButton(
    BuildContext context,
    bool isFieldsReady,
    List<TextEditingController> matrixControllers,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  MatrixRequest request = parseRequest(
                    int.parse(rowsController.text),
                    int.parse(columnsController.text),
                    matrixControllers,
                  );

                  BlocProvider.of<RankBloc>(context)
                      .add(RankRequested(request: request));
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

  Widget matrixResetButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<RankBloc>(context).add(const RankReset());
      },
      child: resetButton(context),
    );
  }

  Widget clearButton(
    BuildContext context,
    List<TextEditingController> matrixControllers,
    TextEditingController rowsController,
    TextEditingController columnsController,
  ) {
    return GestureDetector(
      onTap: () {
        matrixControllers.add(rowsController);
        matrixControllers.add(columnsController);

        for (var element in matrixControllers) {
          element.clear();
        }

        setState(() {
          isMatrixReady = false;
          isMatrixGenerated = false;
        });
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget matrixClearButton(
      BuildContext context, List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: GestureDetector(
          onTap: () {
            for (var element in controllers) {
              element.clear();
            }

            setState(() {
              isMatrixReady = false;
            });
          },
          child: clearButtonDecoration(context),
        ),
      ),
    );
  }

  Widget generateMatrixButton(
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
                  tag: "Input Matrix",
                  rows: rows > 5 ? 5 : rows,
                  columns: columns > 5 ? 5 : columns,
                  title: "Matrix Rank");
            }));
          },
          child: Hero(
            tag: "Input Matrix",
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
    int rows,
    int columns,
    List<TextEditingController> controllers,
  ) {
    List<List<double>> matrix = [];

    for (var i = 0; i < columns; i++) {
      List<double> tmp = [];
      for (var j = 0; j < rows; j++) {
        tmp.add(parseValue(controllers[columns * i + j].text));
      }
      matrix.add(tmp);
    }
    return MatrixRequest(matrixA: matrix, matrixB: null);
  }

  Widget textField(
    BuildContext context,
    TextEditingController controller,
    String hint,
    double width,
  ) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            setState(() {
              isMatrixGenerated = false;
            });
            if (rowsController.text.isNotEmpty &&
                columnsController.text.isNotEmpty) {
              setState(() {
                isMatrixReady = true;
              });
            } else {
              setState(() {
                isMatrixReady = false;
              });
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
}
