import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';

class MatrixInputCard extends StatelessWidget {
  final String label;
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final Widget actionButton;
  final EdgeInsets? padding;

  const MatrixInputCard({
    super.key,
    required this.label,
    required this.rowsController,
    required this.columnsController,
    required this.actionButton,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextFieldLabel(label: label),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: CustomTextField(
                  controller: rowsController,
                  hint: 'Rows',
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 180,
                child: CustomTextField(
                  controller: columnsController,
                  hint: 'Columns',
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64,),
            child: actionButton,
          ),
        ],
      ),
    );
  }
}


 