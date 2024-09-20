import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/app/enums/ib_section.dart';
import 'package:economics_app/sections/quizzes/quiz_data/number_of_questions.dart';
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
import 'add_question/add_question_page.dart';
import 'methods/create_units_dropdown_menu_items.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  final ExpandableController _expandableController =
  ExpandableController(initialExpanded: false);

  bool _expanded = false;

  @override
  void initState() {
    super.initState();

    _expandableController.addListener(() {
      setState(() {
        _expanded = _expandableController.expanded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;
    final kVerticalSettingsGap = height * 0.01;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
      question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    WidgetsBinding.instance.addPostFrameCallback((t){
      if(quizState.course == Course.ib){

      }
    });



    return Stack(
      children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomPageHeading(
                icon: const Icon(
                  Icons.question_answer_outlined,
                ),
                title: 'Quiz',
                trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddQuestionPage()));
                    },
                    icon: const Icon(Icons.add)),
              ),
            ];
          },
          body: SingleChildScrollView(
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
                    CustomChipButton(text: Course.ib.toText(),
                      onPressed: () {}, isSelected: true,),
                    CustomChipButton(text: Course.igcse.toText(),
                      onPressed: () {}, isSelected: true,),
                  ],
                ),
                SizedBox(
                  height: kVerticalSettingsGap,
                ),
                ExpandableNotifier(
                  controller: _expandableController,
                  child: ExpandablePanel(
                    header: const ListTile(
                      title: Text('More quiz options'),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: Column(
                      children: [
                        CustomDropDown(
                          value: quizState.section,
                          items: quizState.sections,
                          onChanged: (e) {
                            final s = e as SectionMixin;
                            quizNotifier.setSection(s);

                            List<DropdownMenuItem<dynamic>> units = createUnitsDropdownMenuItems(s);
                            quizNotifier
                              ..setUnits(units)
                              ..setUnit(e.units.first);
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
                          title: Text('Number of questions',textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: size.width * kWrapSpacing,
                            children: [
                              ...numberOfQuestions.map(
                                    (q) {
                                  return CustomChipButton(
                                    text: q.toString(),
                                    isSelected:
                                    quizState.numberOfQuestionsSelected ==
                                        q,
                                    onPressed: () {
                                      quizNotifier
                                          .setNumberOfQuestionsSelected(q);
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
                            title: const Text('Check answers as I go'),
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
                  height: _expanded ? size.height * 0.15 : size.height * 0.30,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.easeInOut,
                ),
                const StartQuizWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
