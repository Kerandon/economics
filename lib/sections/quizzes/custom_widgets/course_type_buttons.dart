import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';

import '../../../app/utils/models/course.dart';
import '../quiz_state/edit_question_state.dart';

class CourseTypeButtons extends ConsumerWidget {
  const CourseTypeButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: size.width * kWrapSpacing,
        children: editState.courses
            .map((e) => CustomChipButton(
          isSelected: e == editState.course,
                text: e.name,
                onPressed: () {
                  editNotifier.setCourse(e);
                }))
            .toList());
  }
}
