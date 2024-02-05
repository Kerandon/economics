// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:economics_app/configs/constants.dart';
// import 'package:economics_app/custom_widgets/custom_progress_indicator.dart';
// import 'package:economics_app/models/article_model.dart';
// import 'package:economics_app/models/topic_model.dart';
// import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
// import 'package:flutter/material.dart';
//
// class UnitPage extends StatefulWidget {
//   const UnitPage({
//     required this.topic,
//     super.key,
//   });
//
//   final TopicModel topic;
//
//   @override
//   State<UnitPage> createState() => _UnitPageState();
// }
//
// class _UnitPageState extends State<UnitPage> {
//   late final Future<DocumentSnapshot<Map<String, dynamic>>> _unitFieldsFuture;
//   late final Future<QuerySnapshot<Map<String, dynamic>>> _articlesFuture;
//
//   @override
//   void initState() {
//     _unitFieldsFuture = getRawDocumentData(
//         '/$kSections/${widget.topic.parent}/$kUnits/${widget.topic.title}');
//   _articlesFuture = getRawCollectionData('/$kSections/${widget.topic.parent}/$kUnits/${widget.topic.title}/$kArticles/');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.topic.title!),
//       ),
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           FutureBuilder(
//             future: Future.wait([_unitFieldsFuture, _articlesFuture]),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<ArticleModel> contents = [];
//
//              final unitData = snapshot.data![0] as DocumentSnapshot<Map<String, dynamic>>;
//
//                 // final data =
//                 //     snapshot.data as DocumentSnapshot<Map<String, dynamic>>;
//
//                 // final topic = TopicModel.parseFromFirebase(document: data);
//
//                 return const Column(
//                   children: [
//                     // CustomExpandable(
//                     //   title: 'Unit Summary',
//                     //   onExpand: CustomTable(topic.terms!),
//                     // ),
//                     // CustomExpandable(
//                     //   title: 'Key Terms',
//                     //   onExpand: CustomTable(
//                     //     Map.fromEntries(
//                     //       topic.summary!.asMap().entries.map(
//                     //             (e) => MapEntry(e.key.toString(), e.value),
//                     //           ),
//                     //     ),
//                     //     useBulletPoints: true,
//                     //   ),
//                     // ),
//                   ],
//                 );
//               }
//               return const CustomProgressIndicator();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
