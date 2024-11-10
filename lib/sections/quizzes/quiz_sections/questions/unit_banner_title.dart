// import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../../app/configs/constants.dart';
// import '../../quiz_state/quiz_state.dart';
//
// class UnitBannerTitle extends ConsumerWidget {
//   const UnitBannerTitle({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     final editState = ref.read(editQuestionProvider);
//     return Padding(
//       padding: EdgeInsets.only(left: size.width * kPageIndentHorizontal),
//       child: SizedBox(
//         width: size.width,
//         height: size.height * 0.04,
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: RichText(
//             text: TextSpan(
//               text: '${editState.unit.index}.${editState.subunit.index} ',
//               style: Theme.of(context).textTheme.bodySmall,
//               children: [
//                 TextSpan(
//                   text:
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
