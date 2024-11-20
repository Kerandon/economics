import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

import 'custom_form_builder_text_field.dart';

class AddFlipQuestionForm extends StatefulWidget {
  const AddFlipQuestionForm({super.key});

  @override
  State<AddFlipQuestionForm> createState() => _AddFlipQuestionFormState();
}

class _AddFlipQuestionFormState extends State<AddFlipQuestionForm> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomFormBuilderTextField(kQuestion),
        ],
      ),
    );
  }
}
