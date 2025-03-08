import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/enums/course_enum.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/utils/models/course_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class CourseButton extends ConsumerWidget {
  const CourseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    CourseModel? currentCourse;
    // Get the current course or default to the first one
    if (editState.currentQuestion.course == null) {
      if(editState.courses.isEmpty){
        throw Exception('no courses');
      }
      CourseModel currentCourse = editState.courses.first;
      WidgetsBinding.instance.addPostFrameCallback((t) {
        editNotifier.updateCurrentQuestion(
            editState.currentQuestion.copyWith(course: currentCourse));
      });
    } else {
      currentCourse = editState.currentQuestion.course;
    }

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: CustomDropdownHeading(
              c.course?.course?.toText() ?? 'Select course'),
          onChanged: (e) {
            editNotifier.updateCurrentQuestion(
              editState.currentQuestion.copyWith(
                course: e,
                unit: e?.units.first,
                subunit: e?.units.first.subunits.first,
              ),
            );
          },
          value: currentCourse,
          items: [
            ...editState.courses.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e.course?.toText() ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
