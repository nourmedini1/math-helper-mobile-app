import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/polar_form/polar_form_initial_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/polar_form/polar_form_success_screen.dart';
import 'package:provider/provider.dart';

class ComplexPolarFormPage extends StatefulWidget {
  const ComplexPolarFormPage({super.key});

  @override
  State<ComplexPolarFormPage> createState() => _ComplexPolarFormPageState();
}

class _ComplexPolarFormPageState extends State<ComplexPolarFormPage> {
  late TextEditingController realController;
  late TextEditingController imaginaryController;
  bool isFieldsReady = false;

  @override
  void initState() {
    super.initState();
    realController = TextEditingController();
    imaginaryController = TextEditingController();
  }

  @override
  void dispose() {
    realController.dispose();
    imaginaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: BlocConsumer<PolarFormBloc, PolarFormState>(
            listener: (context, state) {
              if (state is PolarFormFailure) {
                showToast(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is PolarFormInitial) {
                return PolarFormInitialScreen(
                    realController : realController,imaginaryController :  imaginaryController);
              } else if (state is PolarFormLoading) {
                return const LoadingScreen();
              } else if (state is PolarFormOperationSuccess) {
                return PolarFormSuccessScreen(response: state.response,);
              } else {
                return PolarFormInitialScreen(
                    realController : realController,imaginaryController :  imaginaryController);
              }
            },
          ),
        ));
  }

  void showToast(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.customWhite,
          ),
        ),
        backgroundColor: AppColors.customRed,
      ),
    );
  }

  
}
