import 'package:economics_app/app/custom_widgets/gap.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/enums/course.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../../quiz_enums/number_of_questions.dart';
import '../../quiz_enums/question_type.dart';
import '../../quiz_state/quiz_state.dart';
import '../add_question/custom_drop_down.dart';
import '../methods/create_sub_units_dropdown.dart';

class QuizOptions extends ConsumerStatefulWidget {
  const QuizOptions({super.key});

  @override
  ConsumerState<QuizOptions> createState() => _QuizOptionsDropdownState();
}

class _QuizOptionsDropdownState extends ConsumerState<QuizOptions> {
  bool _setSectionsOnInit = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (!_setSectionsOnInit) {
      _setSectionsOnInit = true;


      WidgetsBinding.instance.addPostFrameCallback((t) {
        if(quizState.units.isNotEmpty){
          quizNotifier
            ..setSection(quizState.section)
            ..setUnits(quizState.units.toList())
            ..setUnit(quizState.unit);

        }else {
          quizNotifier.setCourse(Course.ib);
        }
      });
    }

    return Column(
      children: [
        const Gap(),
        ListTile(
          leading: Text(
            'Quiz type',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          title: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              CustomChipButton(
                text: QuestionType.multi.toText(),
                onPressed: () {
                  quizNotifier.setQuestionType(QuestionType.multi);
                },
                isSelected: quizState.questionType == QuestionType.multi,
              ),
              CustomChipButton(
                text: QuestionType.flip.toText(),
                onPressed: () {
                  quizNotifier.setQuestionType(QuestionType.flip);
                },
                isSelected: quizState.questionType == QuestionType.flip,
              ),
            ],
          ),
        ),
        const Gap(
          showDivider: true,
        ),
        ListTile(
          leading: Text(
            'Course',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          title: Wrap(
            spacing: size.width * kWrapSpacing,
            children: [
              CustomChipButton(
                text: Course.ib.toText(),
                onPressed: () {
                  quizNotifier.setCourse(Course.ib);
                },
                isSelected: quizState.course == Course.ib,
              ),
              CustomChipButton(
                text: Course.igcse.toText(),
                onPressed: () {
                  quizNotifier.setCourse(Course.igcse);
                },
                isSelected: quizState.course == Course.igcse,
              ),
            ],
          ),
        ),
        const Gap(),
        CustomDropDown(
          value: quizState.section,
          items: quizState.sections,
          onChanged: (e) {
            final s = e as UnitMixin;

            quizNotifier.setSection(s);
            List<DropdownMenuItem<dynamic>> units = createSubUnitsDropdown((s));

            quizNotifier
              ..setUnit(e.subUnits.first)
              ..setUnits(units);
          },
        ),
        const Gap(),
        CustomDropDown(
          value: quizState.unit,
          items: quizState.units,
          onChanged: (e) {
            quizNotifier.setUnit(e);
          },
        ),
        const Gap(
          showDivider: true,
        ),
        ListTile(
          leading: Text(
            'Number of questions',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          title: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              ...NumberOfQuestions.values.map(
                (q) {
                  return CustomChipButton(
                    text: q.name,
                    isSelected: quizState.numberOfQuestionsSelected == q.value,
                    onPressed: () {
                      quizNotifier.setNumberOfQuestionsSelected(q.value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const Gap(
          showDivider: true,
        ),
        SwitchListTile(
            title: const Text('Check answers one by one'),
            value: quizState.showAnswersAsIGo,
            onChanged: (on) {
              quizNotifier.setShowAnswersAsIGo(on);
            }),
        const Gap(
          showDivider: true,
        ),
      ],
    );
  }
}
