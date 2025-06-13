import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/rank/rank_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/rank/rank_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/rank/rank_success_screen.dart';

class RankScreen extends StatelessWidget {
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final List<TextEditingController> matrixControllers;
  const RankScreen({
    super.key,
    required this.rowsController,
    required this.columnsController,
    required this.matrixControllers,
    });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<RankBloc, RankState>(
        listener: (context, state) {
         if (state is RankFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is RankInitial) {
            return RankInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,
            );
          } else if (state is RankLoading) {
            return const LoadingScreen();
          } else if (state is RankSuccess) {
            return RankSuccessScreen(
              matrix: state.response.matrixA!,
              resultMatrix: state.response.rank!,
            
            );
          } else if (state is RankFailure) {
            return RankInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,      
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

   void showToast(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.customRed,
      ),
    );
  }
}

