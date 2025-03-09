
import 'package:economics_app/sections/settings/manage_questions/question_type_button.dart';
import 'package:economics_app/sections/settings/manage_questions/subunits_button.dart';
import 'package:economics_app/sections/settings/manage_questions/syllabus_buttons.dart';
import 'package:economics_app/sections/settings/manage_questions/tags_button.dart';
import 'package:economics_app/sections/settings/manage_questions/units_button.dart';
import 'package:flutter/material.dart';


class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: SyllabusButton(),
        ),
        Expanded(
          flex: 10,
          child: UnitsButton(),
        ),
        Expanded(
          flex: 10,
          child: SubunitsButton(),
        ),
        Expanded(
          flex: 10,
          child: QuestionTypeButton(),
        ),
        Expanded(
          flex: 10,
          child: TagsButton(),
        ),
      ],
    );
  }
}
