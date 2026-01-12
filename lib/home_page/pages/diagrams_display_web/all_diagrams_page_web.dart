// import 'package:economics_app/diagrams/data/all_diagrams.dart';
// import 'package:economics_app/diagrams/enums/diagram_enum.dart';
// import 'package:economics_app/home_page/state_management/home_page_state.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../../../diagrams/enums/unit_type.dart';
// import '../../../diagrams/models/diagram_widget.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// import 'diagram_content_area.dart';
// import 'diagram_row.dart';
// import 'diagrams_side_bar.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
//
//
// class AllDiagramsPageWeb extends ConsumerStatefulWidget {
//   const AllDiagramsPageWeb({super.key});
//
//   @override
//   ConsumerState<AllDiagramsPageWeb> createState() =>
//       _AllDiagramsPageWebState();
// }
//
// class _AllDiagramsPageWebState extends ConsumerState<AllDiagramsPageWeb> {
//   final ScrollController _scrollController = ScrollController();
//   final Map<String, GlobalKey> _diagramKeys = {}; // key per diagram
//   bool _isManualScroll = false;
//   bool _isExporting = false;
//
//   // --- Constants for PDF Layout ---
//   static const int diagramsPerCol = 4; // Length-wise
//   static const int diagramsPerRow = 3; // Horizontal
//   static const int diagramsPerPage = diagramsPerCol * diagramsPerRow;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollSpyListener);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollSpyListener);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _scrollSpyListener() {
//     if (_isManualScroll) return;
//     final homePageNotifier = ref.read(homePageProvider.notifier);
//     for (var entry in _diagramKeys.entries) {
//       final box = entry.value.currentContext?.findRenderObject() as RenderBox?;
//       if (box != null) {
//         final position = box.localToGlobal(Offset.zero).dy;
//         if (position < 200 && position > -200) {
//           homePageNotifier.setSelectedDiagramId(entry.key);
//           break;
//         }
//       }
//     }
//   }
//
//   void _scrollToDiagram(String id) {
//     final key = _diagramKeys[id];
//     final context = key?.currentContext;
//     if (context != null) {
//       _isManualScroll = true;
//       ref.read(homePageProvider.notifier).setSelectedDiagramId(id);
//       Scrollable.ensureVisible(
//         context,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       ).then(
//             (_) => Future.delayed(const Duration(milliseconds: 500), () {
//           _isManualScroll = false;
//         }),
//       );
//     }
//   }
//
//   /// Converts a CustomPainter to high-resolution PNG bytes
//   Future<Uint8List> _captureDiagram(CustomPainter painter, double size,
//       {double scale = 3.0}) async {
//     final int pixelSize = (size * scale).toInt();
//
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//
//     // scale canvas for high-res rendering
//     canvas.scale(scale);
//     painter.paint(canvas, Size(size, size));
//
//     final picture = recorder.endRecording();
//     final img = await picture.toImage(pixelSize, pixelSize);
//     final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//
//     return byteData!.buffer.asUint8List();
//   }
//
//   /// Exports all diagrams to a single PDF file (4x3 grid)
//   Future<void> _exportToPDF(List<DiagramBundle> allBundles, double size) async {
//     setState(() => _isExporting = true);
//
//     final pdf = pw.Document();
//
//     // Use Unicode font for titles
//     final font = await PdfGoogleFonts.openSansRegular();
//
//     final double diagramSize = size;
//
//     // Prepare diagram rows
//     final List<DiagramRow> diagramRows = [];
//     for (final bundle in allBundles) {
//       final title = bundle.diagramBundleEnum?.toText ?? 'Untitled Diagram';
//       final List<pw.MemoryImage> images = [];
//
//       for (final painter in bundle.basePainterDiagrams) {
//         final imageBytes =
//         await _captureDiagram(painter, diagramSize, scale: 3.0);
//         images.add(pw.MemoryImage(imageBytes));
//       }
//
//       diagramRows.add(DiagramRow(title: title, images: images));
//     }
//
//     // Group rows into pages of 12 diagrams
//     for (int i = 0; i < diagramRows.length; i += diagramsPerPage) {
//       final group = diagramRows.skip(i).take(diagramsPerPage).toList();
//
//       pdf.addPage(
//         pw.Page(
//           margin: const pw.EdgeInsets.all(16),
//           build: (pw.Context context) {
//             return pw.GridView(
//               crossAxisCount: diagramsPerRow,
//               childAspectRatio: 1.1,
//               children: group.map((row) {
//                 final cellWidth =
//                     context.page.pageFormat.availableWidth / diagramsPerRow;
//                 final imageWidth =
//                 row.images.length == 2 ? cellWidth * 0.45 : cellWidth * 0.9;
//
//                 return pw.Container(
//                   padding: const pw.EdgeInsets.all(8),
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.center,
//                     children: [
//                       pw.Text(
//                         row.title,
//                         textAlign: pw.TextAlign.center,
//                         style: pw.TextStyle(
//                           font: font,
//                           fontSize: 10,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 4),
//                       row.images.length == 2
//                           ? pw.Row(
//                         mainAxisAlignment:
//                         pw.MainAxisAlignment.spaceEvenly,
//                         children: row.images
//                             .map((img) => pw.Image(
//                           img,
//                           width: imageWidth,
//                           height: imageWidth,
//                           fit: pw.BoxFit.contain,
//                         ))
//                             .toList(),
//                       )
//                           : pw.Image(
//                         row.images.first,
//                         width: imageWidth,
//                         height: imageWidth,
//                         fit: pw.BoxFit.contain,
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       );
//     }
//
//     await Printing.sharePdf(
//       bytes: await pdf.save(),
//       filename: 'All_Diagrams.pdf',
//     );
//
//     setState(() => _isExporting = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final colorScheme = Theme.of(context).colorScheme;
//
//     final allBundles = AllDiagrams(
//       size: size,
//       colorScheme: colorScheme,
//     ).getDiagramBundles(getAll: true);
//
//     final Map<UnitType, Map<Subunit, List<DiagramBundle>>> bundlesByUnit = {};
//     for (var bundle in allBundles) {
//       final enumValue = bundle.diagramBundleEnum;
//       if (enumValue == null) continue;
//
//       final unit = enumValue.unit;
//       final subunit = enumValue.subunit;
//       bundlesByUnit.putIfAbsent(unit, () => {});
//       bundlesByUnit[unit]!.putIfAbsent(subunit, () => []);
//       bundlesByUnit[unit]![subunit]!.add(bundle);
//
//       final id = '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';
//       _diagramKeys[id] ??= GlobalKey();
//     }
//
//     final sortedUnits = bundlesByUnit.keys.toList()
//       ..sort((a, b) {
//         final aNum =
//             double.tryParse(a.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
//         final bNum =
//             double.tryParse(b.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
//         return aNum.compareTo(bNum);
//       });
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Diagrams'),
//         actions: [
//           IconButton(
//             icon: _isExporting
//                 ? const CircularProgressIndicator(color: Colors.white)
//                 : const Icon(Icons.picture_as_pdf),
//             tooltip: 'Export all diagrams to PDF',
//             onPressed: _isExporting
//                 ? null
//                 : () async {
//               await _exportToPDF(allBundles, 400);
//             },
//           ),
//         ],
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DiagramsSidebar(
//             bundlesByUnit: bundlesByUnit,
//             sortedUnits: sortedUnits,
//             onDiagramSelected: _scrollToDiagram,
//           ),
//           DiagramsContentArea(
//             sortedUnits: sortedUnits,
//             bundlesByUnit: bundlesByUnit,
//             diagramKeys: _diagramKeys,
//             scrollController: _scrollController,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// Simple wrapper class to represent a row in the PDF
// class DiagramRow {
//   final String title;
//   final List<pw.MemoryImage> images;
//
//   DiagramRow({required this.title, required this.images});
// }
