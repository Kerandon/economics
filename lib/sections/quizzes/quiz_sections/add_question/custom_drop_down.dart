// import 'package:economics_app/sections/quizzes/quiz_sections/add_question/select_sections_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class CustomDropDown extends ConsumerWidget {
//   const CustomDropDown({
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     super.key,
//   });
//
//   final dynamic value;
//   final List<DropdownMenuItem> items;
//   final Function(dynamic) onChanged;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         if (value != null) ...[
//           CustomDropDown(
//             value: value,
//             items: items,
//             onChanged: (e) {
//               onChanged.call(e);
//             },
//           ),
//         ],
//       ],
//     );
//   }
// }
