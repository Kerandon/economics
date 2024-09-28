import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';

import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/add_question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/custom_drop_down.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/methods/get_questions_from_firebase.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/enums/course.dart';
import '../../../app/utils/mixins/section_mixin.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_enums/number_of_questions.dart';
import '../quiz_models/question_model.dart';
import 'methods/create_units_dropdown_menu_items.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: false);
  bool _setSectionsOnInit = false;
  bool _downloadedAllQuestionsOnInit = false;
  late final Future<List<QuestionModel>> _questionFuture;

  @override
  void initState() {
    _questionFuture = getQuestionsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    if (!_setSectionsOnInit) {
      _setSectionsOnInit = true;

      WidgetsBinding.instance.addPostFrameCallback((e) {
        quizNotifier.setCourse(Course.ib);
      });
    }
    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Stack(
        children: [
          NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CustomPageHeading(
                  icon: const Icon(
                    Icons.question_answer_outlined,
                    color: Colors.white,
                  ),
                  title: 'Quiz',
                  trailing: Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: SizedBox(
                      height: size.height * 0.06,
                      width: size.height * 0.06,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        // Ensures the icon scales down to fit inside
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddQuestionPage(),),);
                          },
                          icon: Icon(Icons.add_outlined,
                              color: Colors.white,
                              size: size.width * 0.20), // Icon size can be large
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: FutureBuilder<List<QuestionModel>>(
                future: _questionFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      if (!_downloadedAllQuestionsOnInit) {
                        _downloadedAllQuestionsOnInit = true;
                        WidgetsBinding.instance.addPostFrameCallback((t) {
                          quizNotifier.setAllQuestions(snapshot.data!.toList());
                        });
                      }

                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * kPageIndentHorizontal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Gap(),
                              ExpandableNotifier(
                                controller: _expandableController,
                                child: ExpandablePanel(
                                  header: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.settings_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text('Quiz options'),
                                      ],
                                    ),
                                  ),
                                  collapsed: const SizedBox.shrink(),
                                  expanded: Column(
                                    children: [
                                      const Gap(),
                                      ListTile(
                                        leading: Text(
                                          'Quiz type',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        ),
                                        title: Wrap(
                                          alignment: WrapAlignment.start,
                                          spacing: size.width * kWrapSpacing,
                                          children: [
                                            CustomChipButton(
                                              text: QuestionType.multi.toText(),
                                              onPressed: () {
                                                quizNotifier.setQuestionType(
                                                    QuestionType.multi);
                                              },
                                              isSelected:
                                                  quizState.questionType ==
                                                      QuestionType.multi,
                                            ),
                                            CustomChipButton(
                                              text: QuestionType.flip.toText(),
                                              onPressed: () {
                                                quizNotifier.setQuestionType(
                                                    QuestionType.flip);
                                              },
                                              isSelected:
                                                  quizState.questionType ==
                                                      QuestionType.flip,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
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
                                              isSelected:
                                                  quizState.course == Course.ib,
                                            ),
                                            CustomChipButton(
                                              text: Course.igcse.toText(),
                                              onPressed: () {
                                                quizNotifier
                                                    .setCourse(Course.igcse);
                                              },
                                              isSelected: quizState.course ==
                                                  Course.igcse,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(),
                                      CustomDropDown(
                                        value: quizState.section,
                                        items: quizState.sections,
                                        onChanged: (e) {
                                          final s = e as SectionMixin;

                                          quizNotifier.setSection(s);
                                          List<DropdownMenuItem<dynamic>> units =
                                              createUnitsDropdownMenuItems(s);

                                          quizNotifier
                                            ..setUnit(e.units.first)
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
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
                                                  isSelected: quizState
                                                          .numberOfQuestionsSelected ==
                                                      q.value,
                                                  onPressed: () {
                                                    quizNotifier
                                                        .setNumberOfQuestionsSelected(
                                                            q.value);
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
                                          title: const Text(
                                              'Check answers one by one'),
                                          value: quizState.showAnswersAsIGo,
                                          onChanged: (on) {
                                            quizNotifier.setShowAnswersAsIGo(on);
                                          }),
                                      const Gap(
                                        showDivider: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.20,
                              ),
                              CustomBigButton(
                                  text: 'Start Quiz',
                                  onPressed: () {
                                    quizNotifier.setSelectedQuestions(
                                        quizState.allQuestions.toList());
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((t) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuestionPage()));
                                    });
                                  }),
                              SizedBox(
                                height: size.height * 0.20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('An error occurred. \n\n'
                              'Please check your internet connection and try again. \n\n', textAlign: TextAlign.center,));

                    }
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                              'No questions\n\nUpload a quiz question (plus icon in the top right) to begin!',
                          style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center,
                          ));
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}
