import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';

class CourseButtons extends ConsumerWidget {
  const CourseButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    // Get the current course or default to the first one
    final currentCourse =
        editState.filterModel.course ?? editState.courses.first;

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        onChanged: (e) {
          editNotifier.updateFilter(editState.filterModel.copyWith(course: e, units: []));
        },
        value: currentCourse,
        items: [
          ...editState.courses.map((e) =>
              DropdownMenuItem(value: e, child: Text(e.course?.name ?? '')))
        ],
      )),
    );
  }
}
