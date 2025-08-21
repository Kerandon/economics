// class FullScreenDiagramsDialog extends StatelessWidget {
//   const FullScreenDiagramsDialog(this.bundle, {super.key});
//
//   final DiagramBundle bundle;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Dialog(
//       insetPadding: const EdgeInsets.all(16),
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxHeight: size.width * 1.5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.close, size: 20),
//                   onPressed: () => Navigator.of(context).pop(),
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(
//                       Theme.of(context).colorScheme.scrim,
//                     ),
//                     shape: WidgetStateProperty.all(const CircleBorder()),
//                   ),
//                 ),
//                 SizedBox(width: size.width * 0.05),
//               ],
//             ),
//             SizedBox(height: size.height * 0.05),
//             //DiagramBundleWidget(fitAll: false, diagramBundle: bundle),
//           ],
//         ),
//       ),
//     );
//   }
// }
