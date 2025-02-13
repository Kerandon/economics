import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.name,
      required this.label,
      required this.onChanged,
      this.minLines = 1,
      super.key});

  final String name;
  final String label;
  final int minLines;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
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
