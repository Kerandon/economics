import 'package:economics_app/sections/quizzes/quiz_enums/flip_card_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/configs/constants.dart';
import '../../app/utils/models/course.dart';
import '../../app/utils/models/unit.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);

    List<int> numberOfQuestions = [...kMaxNumberOfQuestions];

    UserPrefs pref = UserPrefs(
      course: startState.course as Course,
      flipCardTag: startState.flipCardTag,
    );

    for (var e in startState.userPrefs) {
      if (e.course == startState.course &&
          e.flipCardTag == startState.flipCardTag) {
        pref = e;
      }
    }

    if (pref.numberOfQuestions == null) {
      pref = pref.copyWith(numberOfQuestions: kMaxNumberOfQuestions.first);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${startState.course.name} - ${startState.flipCardTag.toText()}'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(child: Text('Number of questions')),
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
                    children: numberOfQuestions.map((e) {
                      bool isSelected = false;
                      if (pref.numberOfQuestions == e) {
                        isSelected = true;
                      }
                      final theme = Theme.of(context);
                      final onSurfaceColor = isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface;
                      return ChoiceChip(
                        selectedColor: theme.colorScheme.primary,
                        checkmarkColor: onSurfaceColor,
                        onSelected: (_) {
                          startNotifier.updateUserPrefs(
                              pref.copyWith(numberOfQuestions: e));
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
                  child: SizedBox(child: Text('Unit')),
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
                      bool isSelected = false;
                      if (pref.selectedUnits?.contains(e) ?? false) {
                        isSelected = true;
                      }
                      final theme = Theme.of(context);
                      final onSurfaceColor = isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface;
                      return ChoiceChip(
                        selectedColor: theme.colorScheme.primary,
                        checkmarkColor: onSurfaceColor,
                        onSelected: (_) {
                          // Create a copy of the current selectedUnits list
                          List<Unit> updatedSelectedUnits =
                              List<Unit>.from(pref.selectedUnits ?? []);

                          // Create a copy of the current selectedSubunits list
                          List<Unit> updatedSelectedSubunits =
                              List<Unit>.from(pref.selectedSubunits ?? []);

                          // Check if the unit already exists in the list
                          if (updatedSelectedUnits.contains(e)) {
                            // If it exists, remove it
                            updatedSelectedUnits.remove(e);

                            // Also remove all its subunits from the selectedSubunits list
                            updatedSelectedSubunits.removeWhere(
                                (subunit) => e.subunits.contains(subunit));
                          } else {
                            // If it doesn't exist, add it
                            updatedSelectedUnits.add(e as Unit);
                          }

                          // Update the user preferences with the new selectedUnits and selectedSubunits lists
                          startNotifier.updateUserPrefs(
                            pref.copyWith(
                              selectedUnits: updatedSelectedUnits,
                              selectedSubunits: updatedSelectedSubunits,
                            ),
                          );
                        },
                        label: Text(
                          e.name!,
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
                  child: SizedBox(child: Text('Subunit')),
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
                                bool isSelected = false;
                                if (pref.selectedSubunits?.contains(e) ??
                                    false) {
                                  isSelected = true;
                                }
                                final theme = Theme.of(context);
                                final onSurfaceColor = isSelected
                                    ? Colors.white
                                    : theme.colorScheme.onSurface;
                                return ChoiceChip(
                                  selectedColor: theme.colorScheme.primary,
                                  checkmarkColor: onSurfaceColor,
                                  onSelected: (_) {
                                    // Create a copy of the current selectedUnits list
                                    List<Unit> updatedSelectedSubunits =
                                        List<Unit>.from(
                                            pref.selectedSubunits ?? []);

                                    // Check if the unit already exists in the list
                                    if (updatedSelectedSubunits.contains(e)) {
                                      // If it exists, remove it
                                      updatedSelectedSubunits.remove(e);
                                    } else {
                                      // If it doesn't exist, add it
                                      updatedSelectedSubunits.add(e);
                                    }

                                    // Update the user preferences with the new selectedUnits list
                                    startNotifier.updateUserPrefs(
                                      pref.copyWith(
                                          selectedSubunits:
                                              updatedSelectedSubunits),
                                    );
                                  },
                                  label: Text(
                                    e.name!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
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
        ],
      ),
    );
  }
}
