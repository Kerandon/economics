import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/custom_drop_down.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz_widget.dart';
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
import 'add_question/add_question_page.dart';
import 'methods/create_units_dropdown_menu_items.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: true);
  bool _setSectionsOnInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final kVerticalSettingsGap = height * 0.01;
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

    return Stack(
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
                trailing: IconButton(
                  onPressed: () {
                    // Your onPressed logic here
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white, // Background color
                        shape: BoxShape.circle, // Make the shape a circle
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.add_outlined,   ),
                          color: Theme.of(context).colorScheme.primary, // Icon color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * kPageIndentHorizontal),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: kVerticalSettingsGap,
                  ),
                  Wrap(
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
                  const Gap(),
                  ExpandableNotifier(
                    controller: _expandableController,
                    child: ExpandablePanel(
                      header: ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.settings_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text('More quiz options'),
                          ],
                        ),
                      ),
                      collapsed: const SizedBox.shrink(),
                      expanded: Column(
                        children: [
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
                          Padding(
                            padding: EdgeInsets.only(top: kVerticalSettingsGap),
                            child: const CustomDivider(),
                          ),
                          ListTile(
                            title: Text(
                              'Number of questions',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: size.width * kWrapSpacing,
                              children: [
                                ...NumberOfQuestions.values.map(
                                  (q) {
                                    return CustomChipButton(
                                      text: q.name,
                                      isSelected:
                                          quizState.numberOfQuestionsSelected ==
                                              q.value,
                                      onPressed: () {
                                        quizNotifier
                                            .setNumberOfQuestionsSelected(
                                                q.value);
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: kVerticalSettingsGap),
                            child: const CustomDivider(),
                          ),
                          SwitchListTile(
                              title: const Text('Check answers one by one'),
                              value: quizState.showAnswersAsIGo,
                              onChanged: (on) {
                                quizNotifier.setShowAnswersAsIGo(on);
                              }),
                          const CustomDivider(),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: size.height * 0.03,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInOut,
                  ),
                  const StartQuizWidget(),
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
