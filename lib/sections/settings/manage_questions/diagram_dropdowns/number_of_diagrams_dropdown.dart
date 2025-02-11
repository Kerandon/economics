// import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../diagrams/enums/diagrams_number.dart';
// import '../../../quizzes/quiz_state/edit_question_state.dart';
// import 'diagram_dropdown.dart';
//
// class NumberOfDiagramsDropdown extends ConsumerWidget {
//   const NumberOfDiagramsDropdown({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     final diagramsNumber =
//         ref.watch(editQuestionProvider.select((state) => state.diagramsNumber));
//     final editNotifier = ref.read(editQuestionProvider.notifier);
//
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Expanded(
//               flex: 2,
//               child: ListTile(
//                 title: Text('Add diagrams'),
//               ),
//             ),
//             DropdownMenu(
//               onSelected: (e) {
//                 editNotifier.setDiagramsNumber(context, size,
//                     diagramsNumber: e!);
//               },
//               initialSelection: diagramsNumber,
//               dropdownMenuEntries: DiagramsNumber.values
//                   .map(
//                     (e) => DropdownMenuEntry(
//                       value: e,
//                       label: e.name.capitalizeFirstLetter(),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//         ...List.generate(
//           diagramsNumber.toInt,
//           (index) => DiagramDropdown(
//           index),
//         )
//       ],
//     );
//   }
// }
