import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/search/search_app_bar.dart';
import 'package:math_helper/core/ui/cubits/search/search_cubit.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchAppBar(controller: controller, theContext: context),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.primaryColor
                      : AppColors.customBlackTint60,
                ),
              );
            }
            if (state is SearchLoaded) {
              return ListView.builder(
                itemCount: state.searchItems.length,
                itemBuilder: (context, index) {
                  return state.searchItems.elementAt(index);
                },
              );
            }
            return const Text("Yes");
          },
        ));
  }
}
