import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/methods/reset_questions_models.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/configs/constants.dart';
import '../../app/utils/models/unit_model.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  bool _haveSetPrefsOnInit = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final quizNotifier = ref.read(quizProvider.notifier);

    UserPref pref = UserPref(
      course: startState.course,
      topicTag: startState.topicTag,
    );

    for (var e in startState.userPrefs) {
      if (e.course == startState.course && e.topicTag == startState.topicTag) {
        pref = e;
      }
    }

    if (!_haveSetPrefsOnInit) {
      _haveSetPrefsOnInit = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (t) {
          startNotifier.setFilteredQuestions(
            pref,
            startState.allTopicQuestions.toList(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Align the text to the left
            Expanded(
              flex: 12,
              child: AutoSizeText(
                '${startState.course} - ${startState.topicTag.toText()}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Text(
                        'Number of questions',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 20,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: size.width * kWrapSpacing,
                      children: startState.numberOfQuestions.map((e) {
                        bool isSelected = false;
                        if (pref.numberOfQuestions == e) {
                          isSelected = true;
                        }
                        final onSurfaceColor = isSelected
                            ? Colors.white
                            : theme.colorScheme.onSurface;
                        return ChoiceChip(
                          selectedColor: theme.colorScheme.primary,
                          checkmarkColor: onSurfaceColor,
                          onSelected: (_) {
                            startNotifier.updateUserPrefs(
                              pref.copyWith(numberOfQuestions: e),
                              startState.allTopicQuestions.toList(),
                            );
                          },
                          label: Text(
                            e.toString(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          selected: isSelected,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Text(
                        'Unit',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 20,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: size.width * kWrapSpacing,
                      children: pref.course.units.map((e) {
                        int number = startState.allTopicQuestions
                            .where((q) => q.unit == e)
                            .length;

                        bool isSelected =
                            pref.selectedUnits?.contains(e) ?? false;

                        final theme = Theme.of(context);
                        final onSurfaceColor = isSelected
                            ? Colors.white
                            : theme.colorScheme.onSurface;

                        return ChoiceChip(
                          label: Text(
                            '${e.name!} ($number)',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          selectedColor: theme.colorScheme.primary,
                          checkmarkColor: onSurfaceColor,
                          onSelected: (_) {
                            // Create a copy of the current selectedUnits list
                            List<UnitModel> updatedSelectedUnits =
                                List<UnitModel>.from(pref.selectedUnits ?? []);

                            // Create a copy of the current selectedSubunits list
                            List<UnitModel> updatedSelectedSubunits =
                                List<UnitModel>.from(
                                    pref.selectedSubunits ?? []);

                            // Check if the unit already exists in the list
                            if (updatedSelectedUnits.contains(e)) {
                              // If it exists, remove it
                              updatedSelectedUnits.remove(e);

                              // Also remove all its subunits from the selectedSubunits list
                              updatedSelectedSubunits.removeWhere(
                                  (subunit) => e.subunits.contains(subunit));
                            } else {
                              // If it doesn't exist, add it
                              updatedSelectedUnits.add(e);
                            }

                            // Update the user preferences with the new selectedUnits and selectedSubunits lists
                            startNotifier.updateUserPrefs(
                              pref.copyWith(
                                selectedUnits: updatedSelectedUnits,
                                selectedSubunits: updatedSelectedSubunits,
                              ),
                              editState.allQuestions.toList(),
                            );
                          },
                          selected: isSelected,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Text(
                        'Subunit',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 20,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: size.width * kWrapSpacing,
                      children: pref.selectedUnits?.expand(
                            (e) {
                              return e.subunits.map(
                                (e) {
                                  int number = startState.allTopicQuestions
                                      .where((q) => q.subunit == e)
                                      .length;

                                  bool isSelected = false;
                                  if (pref.selectedSubunits?.contains(e) ??
                                      false) {
                                    isSelected = true;
                                  }

                                  final onSurfaceColor = isSelected
                                      ? Colors.white
                                      : theme.colorScheme.onSurface;
                                  return ChoiceChip(
                                    selectedColor: theme.colorScheme.primary,
                                    checkmarkColor: onSurfaceColor,
                                    onSelected: (_) {
                                      List<UnitModel> updatedSelectedSubunits =
                                          List<UnitModel>.from(
                                              pref.selectedSubunits ?? []);
                                      if (updatedSelectedSubunits.contains(e)) {
                                        updatedSelectedSubunits.remove(e);
                                      } else {
                                        updatedSelectedSubunits.add(e);
                                      }
                                      startNotifier.updateUserPrefs(
                                        pref.copyWith(
                                          selectedSubunits:
                                              updatedSelectedSubunits,
                                        ),
                                        startState.allTopicQuestions.toList(),
                                      );
                                    },
                                    label: Text(
                                      '${e.name!} ($number)',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    selected: isSelected,
                                  );
                                },
                              );
                            },
                          ).toList() ??
                          [],
                    ),
                  ),
                ],
              ),
            ),
            if (pref.topicTag == TopicTag.multipleChoiceQuestion) ...[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Show answers at end',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Switch(
                          value: pref.showAnswersAtEnd ?? false,
                          onChanged: (value) {
                            startNotifier.updateUserPrefs(
                              pref.copyWith(showAnswersAtEnd: value),
                              startState.allTopicQuestions.toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
              child: CustomChipButton(
                isDisabled: startState.filteredQuestions.isEmpty,
                text: 'START',
                onPressed: () {
                  quizNotifier.setSelectedQuestions(
                      resetAnswerStage(startState.filteredQuestions.toList()));

                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuestionPage(),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
