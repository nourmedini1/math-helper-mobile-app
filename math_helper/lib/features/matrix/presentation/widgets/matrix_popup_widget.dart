import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class MatrixPopup extends StatelessWidget {
  final String title;
  final String label;
  final List<TextEditingController> controllers;
  final int rows;
  final int columns;
  final VoidCallback onConfirm;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  const MatrixPopup({
    super.key,
    required this.title,
    required this.label,
    required this.controllers,
    required this.rows,
    required this.columns,
    required this.onConfirm,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context, listen: false).themeData;
    final double maxDialogHeight = MediaQuery.of(context).size.height * 0.8;
    final double maxDialogWidth = 400.0;

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxDialogWidth,
          maxHeight: maxDialogHeight,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: theme == AppThemeData.lightTheme
                          ? AppColors.primaryColorTint50
                          : AppColors.primaryColor,
                      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                      fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: TextFieldLabel(label: label)),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows * columns,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: textFieldDecoration(context),
                      child: TextField(
                        onChanged: onChanged,
                        cursorColor: AppColors.primaryColor,
                        controller: controllers[index],
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SubmitButton(
                  text: "Confirm",
                  icon: Icons.check,
                  color: theme == AppThemeData.lightTheme
                      ? AppColors.primaryColorTint50
                      : AppColors.primaryColor,
                  onPressed: onConfirm,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ClearButton(
                  text: "Clear All",
                  icon: Icons.clear,
                  color: AppColors.secondaryColor,
                  onPressed: onClear,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}