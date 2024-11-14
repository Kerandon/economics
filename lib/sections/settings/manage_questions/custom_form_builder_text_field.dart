import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        minLines: 1,
        maxLines: 5,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        decoration: InputDecoration(
          label: Text(text.capitalizeFirstLetter()),
        ),
        name: text);
  }
}
