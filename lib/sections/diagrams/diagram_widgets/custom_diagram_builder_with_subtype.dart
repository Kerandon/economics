// import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
// import 'package:economics_app/sections/diagrams/diagram_widgets/diagram_box.dart';
// import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import '../enums/diagram_subtype.dart';
// import '../enums/diagram_type.dart';
//
// class CustomDiagramBuilderWithSubtype extends StatefulWidget {
//   const CustomDiagramBuilderWithSubtype({
//     super.key,
//     required this.diagram,
//     this.dimensions = 0.40,
//   });
//
//   final DiagramModel diagram;
//   final double dimensions;
//
//   @override
//   State<CustomDiagramBuilderWithSubtype> createState() =>
//       _CustomDiagramBuilderWithSubtypeState();
// }
//
// class _CustomDiagramBuilderWithSubtypeState
//     extends State<CustomDiagramBuilderWithSubtype> {
//   final Map<String, DiagramSubtype?> _selectedSubtypes = {};
//   DiagramModel? selectedDiagram;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     List<DiagramModel> diagramsToShow = [];
//     // = DiagramModel.getDiagramsByType(
//     //     size, context,
//     //     type: widget.diagram.type);
//     //
//     // if (selectedDiagram == null && diagramsToShow.isNotEmpty) {
//     //   selectedDiagram = diagramsToShow.first;
//     // }
//     //
//     // final havePairedDiagram = selectedDiagram?.type2 != null &&
//     //     selectedDiagram?.subtype2 != null;
//
//    // final selectedD = DiagramModel.getSelectedDiagrams(
//    //    size,
//    //    context,
//    //    selectedDiagrams: [
//    //      DiagramModel(
//    //        unit: selectedDiagram?.unit,
//    //        type: selectedDiagram?.type2,
//    //        subtype: selectedDiagram?.subtype2,
//    //        description: '',
//    //      )
//    //    ],
//    //  ).first;
// print('selected D is ${selectedD}');
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         ...[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DiagramBox(
//                 selectedDiagram: selectedDiagram,
//                 dimensions: widget.dimensions,
//               ),
//               if (havePairedDiagram) ...[
//                 // DiagramBox(
//                 //     selectedDiagram: selectedD,
//                 //     dimensions: widget.dimensions),
//               ],
//               if(havePairedDiagram == false)...[
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(28.0),
//                     child: HtmlWidget(selectedDiagram!.description ?? '',
//                       textStyle: Theme.of(context).textTheme.titleLarge,),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//           if(havePairedDiagram == true)...[
//             Padding(
//               padding: const EdgeInsets.all(28.0),
//               child: HtmlWidget(selectedDiagram!.description ?? '',
//                 textStyle: Theme.of(context).textTheme.titleLarge,),
//             ),
//           ]
//         ],
//         Wrap(
//           children: [
//             ...diagramsToShow.map(
//               (e) {
//                 String text = '${e.subtype?.toText()}';
//                 if (e.subtype2 != null) {
//                   text = '$text - ${e.subtype2?.toText()}';
//                 }
//                 return CustomChipButton(
//                   isSelected: e.type == selectedDiagram?.type &&
//                       e.subtype == selectedDiagram?.subtype &&
//                       e.type2 == selectedDiagram?.type2 &&
//                       e.subtype2 == selectedDiagram?.subtype2,
//                   text: text,
//                   onPressed: () {
//                     selectedDiagram = e;
//                     setState(() {});
//                   },
//                 );
//               },
//             ),
//           ],
//         )
//       ],
//     );
//   }
//
//   void _showFullScreenDiagram(DiagramModel diagram) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(
//             leading: SizedBox.shrink(),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(Icons.close_outlined)),
//             ],
//             title: Text(
//               [
//                 diagram.type?.toText(),
//                 diagram.subtype?.toText(),
//               ].whereType<String>().join(' - '),
//             ),
//           ),
//           body: Center(
//             child: InteractiveViewer(
//               panEnabled: true,
//               minScale: 0.5,
//               maxScale: 4.0,
//               child: AspectRatio(
//                 aspectRatio: 1, // Ensures width and height are equal
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: CustomPaint(
//                     painter: diagram.painter,
//                     size: Size.infinite, // Painter will be given square space
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
