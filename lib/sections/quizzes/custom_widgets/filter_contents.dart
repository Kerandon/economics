import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/course_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/quiz_filter_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/unit_drop_down.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../quiz_enums/topic_tag.dart';

class FilterContents extends ConsumerWidget {
  const FilterContents({
    this.showQuestionType = true,
    this.alwaysShowAllUnits = false,
    this.showCourseType = true,
    this.showNumberOfQuestions = true,
    this.showCheckAnswersAtEnd = true,
    super.key,
  });

  final bool showQuestionType;
  final bool showCourseType;
  final bool showNumberOfQuestions;
  final bool showCheckAnswersAtEnd;
  final bool alwaysShowAllUnits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
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
            if (showCourseType) ...[
              const CourseTypeButtons(),
              const Gap(
                showDivider: true,
              ),
            ],
            const QuizFilterButtons(),
            const Gap(
              showDivider: true,
            ),
            UnitDropDown(
              alwaysShowAllUnits: alwaysShowAllUnits,
            ),
            const Gap(
              showDivider: true,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: size.width * kWrapSpacing,
              children: TopicTag.values.map(
                (e) {
                  final isSelected = editState.selectedFlipCardTags.contains(e);
                  final onSurfaceColor = isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface;
                  return ChoiceChip(
                    checkmarkColor: onSurfaceColor,
                    label: Text(
                      e.toText(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: onSurfaceColor,
                          ),
                    ),
                    selected: isSelected,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    onSelected: (_) {
                      editNotifier.setSelectedFlipCardTags(e);
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
