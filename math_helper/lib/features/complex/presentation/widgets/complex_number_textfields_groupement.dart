import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_title.dart';

class ComplexNumberTextFieldsGroupement extends StatefulWidget {
  final String label;
  final String realNumberHintText;
  final String imaginaryNumberHintText;
  final TextEditingController realController;
  final TextEditingController imaginaryController;
  final void Function(String) onChanged;
  const ComplexNumberTextFieldsGroupement({super.key, required this.label, required this.realNumberHintText, required this.imaginaryNumberHintText, required this.realController, required this.imaginaryController, required this.onChanged});

  @override
  State<ComplexNumberTextFieldsGroupement> createState() => _ComplexNumberTextFieldsGroupementState();
}

class _ComplexNumberTextFieldsGroupementState extends State<ComplexNumberTextFieldsGroupement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TextFieldLabel(label: widget.label)
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hint: widget.realNumberHintText,
          controller: widget.realController,
          onChanged: widget.onChanged,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hint: widget.imaginaryNumberHintText,
          controller: widget.imaginaryController,
          onChanged: widget.onChanged,
        ),
      ],
    ),
  );
  }
}