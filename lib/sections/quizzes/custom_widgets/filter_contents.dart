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
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * kPageIndentHorizontal,
        top: size.height * kPageIndentVertical,
        right: size.width * kPageIndentHorizontal,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QuizTypeButtons(),
          CourseTypeButtons(),
          QuizFilterButtons(),
          UnitDropDown(
            canFilterByAll: true,
          ),
          NumberOfQuestionsButtons(),
          CheckAnswersAtEndButton(),
        ],
      ),
    );
  }
}
