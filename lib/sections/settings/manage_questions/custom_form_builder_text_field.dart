import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/flip_card_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';

class CustomFormBuilderTextField extends ConsumerWidget {
  const CustomFormBuilderTextField(
    this.text, {
    super.key,
    this.validationRequired = true,
  });

  final String text;
  final bool validationRequired;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final questionType = editState.flipCardTag.toQuestionType();
    return FormBuilderTextField(
      minLines:
          text == kCorrectAnswer && questionType == QuestionType.flip ? 5 : 1,
      maxLines: 500,
      validator: validationRequired
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ])
          : null,
      decoration: InputDecoration(
        label: Text(text.capitalizeFirstLetter()),
      ),
      name: text,
    );
  }
}
