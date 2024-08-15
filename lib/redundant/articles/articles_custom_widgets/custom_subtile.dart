// import 'package:economics_app/app/state/app_state.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../articles_models/article_model.dart';
// import '../articles_pages/study_contents.dart';
//
// class CustomSubTile extends ConsumerWidget {
//   const CustomSubTile(
//     this.article, {
//     this.removeDivider = false,
//     super.key,
//   });
//
//   final ArticleModel article;
//   final bool removeDivider;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width * 0.20;
//     final appState = ref.read(appProvider.notifier);
//     return Column(
//       children: [
//         ListTile(
//             onTap: () {
//
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const ContentsPage(),
//                 ),
//               );
//             },
//             leading: Container(
//               width: width,
//               height: width,
//               color: Colors.red,
//             ),
//             title: Text(article.title ?? "")),
//         if (!removeDivider) ...[const Divider()]
//       ],
//     );
//   }
// }
