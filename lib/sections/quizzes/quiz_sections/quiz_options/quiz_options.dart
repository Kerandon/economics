import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/quiz_options/quiz_options_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/utils/mixins/course_mixin.dart';
import '../../../../app/utils/models/course.dart';
import '../../../settings/edit_courses/helper_methods/get_course_data_from_firebase.dart';
import '../../quiz_enums/number_of_questions.dart';
import '../../quiz_enums/question_type.dart';
import '../../quiz_state/quiz_state.dart';

class QuizOptions extends ConsumerStatefulWidget {
  const QuizOptions({super.key});

  @override
  ConsumerState<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends ConsumerState<QuizOptions> {
  List<CourseMixin> courses = [];
  bool _setUpStateOnInit = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
        future: getCourseData(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            if (!_setUpStateOnInit) {
              _setUpStateOnInit = true;
              for (var e in snapshot.data!.docs) {
                courses.add(
                  Course.fromMap({
                    e.id: e.data(),
                  }),
                );
              }

              if (quizState.course.name == "") {
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  quizNotifier.setCourse(courses.first);
                });
              }
            }
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
                  spacing: 20,
                  children: courses.map((c) {
                    return CustomChipButton(
                      isSelected: c.name == quizState.course.name,
                      onPressed: () {
                        quizNotifier.setCourse(c);
                      },
                      text: c.name,
                    );
                  }).toList(),
                ),
              ),
              const Gap(),
              const QuizOptionsDropdown(),
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
                          isSelected:
                              quizState.numberOfQuestionsSelected == q.value,
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
        });
  }
}
