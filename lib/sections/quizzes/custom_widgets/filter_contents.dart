import 'package:economics_app/sections/quizzes/custom_widgets/check_answers_at_end_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/course_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/number_of_questions_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/quiz_filter_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/quiz_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/unit_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';

class FilterContents extends ConsumerWidget {
  const FilterContents({
    this.showExtraButtons = true,
    this.alwaysShowAllUnits = false,
    super.key,
  });

  final bool showExtraButtons;
  final bool alwaysShowAllUnits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * kPageIndentHorizontal,
          top: size.height * kPageIndentVertical,
          right: size.width * kPageIndentHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const QuizTypeButtons(),
            const CourseTypeButtons(),
            const QuizFilterButtons(),
            UnitDropDown(
              alwaysShowAllUnits: alwaysShowAllUnits,
            ),
            if (showExtraButtons) ...[
              const NumberOfQuestionsButtons(),
              const CheckAnswersAtEndButton(),
            ],
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
