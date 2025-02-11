import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.name, required this.onChanged, super.key});

  final String name;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      onChanged: (value) {
        onChanged.call(value);
      },
      name: name,
      decoration: InputDecoration(
        label: Text(name),
      ),
    );
  }
}
