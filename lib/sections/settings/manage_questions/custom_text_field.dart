import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.name,
      required this.label,
      required this.onChanged,
      this.minLines = 1,
      this.initialValue,
      super.key});

  final String name;
  final String label;
  final int minLines;
  final Function(String?) onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initialValue,
      minLines: minLines,
      maxLines: 999999,
      onChanged: (value) {
        onChanged.call(value);
      },
      name: name,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}
