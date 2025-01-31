// import 'package:economics_app/app/configs/constants.dart';
// import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../quiz_enums/number_of_questions.dart';
// import '../quiz_state/edit_question_state.dart';
//
// class NumberOfQuestionsButtons extends ConsumerWidget {
//   const NumberOfQuestionsButtons({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     final editState = ref.watch(editQuestionProvider);
//     final editNotifier = ref.read(editQuestionProvider.notifier);
//     final theme = Theme.of(context);
//
//     List<int> numbers = [];
//     int numberOfFilteredQuestions = 0;
//
//     if (editState.quizFilter == QuizFilter.all) {
//       for (var q in editState.allQuestions) {
//         if (q.course == editState.course) {
//           numberOfFilteredQuestions++;
//         }
//       }
//     } else {
//       numberOfFilteredQuestions = editState.filteredQuestions.length;
//     }
//
//     if (numberOfFilteredQuestions > 0) {
//       if (numberOfFilteredQuestions >= 5) {
//         for (var n in NumberOfQuestions.values) {
//           if (numberOfFilteredQuestions >= n.toInt) {
//             numbers.add(n.toInt);
//           }
//         }
//       }
//       if (NumberOfQuestions.values
//           .every((e) => e.toInt != numberOfFilteredQuestions)) {
//         numbers.add(numberOfFilteredQuestions);
//       }
//       WidgetsBinding.instance.addPostFrameCallback((t) {
//         // if (!numbers.contains(editState.maxNumberOfQuestions)) {
//         //   editNotifier.setNumberOfQuestions(numbers.first);
//         // }
//       });
//     }
//
//     return ListTile(
//       title: const Text('Number of questions'),
//       trailing: Wrap(
//         alignment: WrapAlignment.center,
//         spacing: size.width * kWrapSpacing,
//         children: numbers.map((e) {
//           final isSelected = e == editState.maxNumberOfQuestions;
//           final onSurfaceColor =
//               isSelected ? Colors.white : theme.colorScheme.onSurface;
//           return ChoiceChip(
//             selectedColor: theme.colorScheme.primary,
//             checkmarkColor: onSurfaceColor,
//             label: Text(
//               e.toString(),
//               style: theme.textTheme.titleSmall?.copyWith(
//                 color: onSurfaceColor,
//               ),
//             ),
//             selected: isSelected,
//             onSelected: (_) => editNotifier.setNumberOfQuestions(e),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
