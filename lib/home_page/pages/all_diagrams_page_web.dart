import 'package:economics_app/diagrams/data/all_diagrams.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/home_page/state_management/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../diagrams/enums/unit_type.dart';
import '../../diagrams/models/diagram_bundle.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AllDiagramsPageWeb extends ConsumerStatefulWidget {
  const AllDiagramsPageWeb({super.key});

  @override
  ConsumerState<AllDiagramsPageWeb> createState() => _AllDiagramsPageWebState();
}

class _AllDiagramsPageWebState extends ConsumerState<AllDiagramsPageWeb> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _diagramKeys = {}; // key per diagram
  bool _isManualScroll = false;
  bool _isExporting = false;

  void _scrollToDiagram(String id) {
    final key = _diagramKeys[id];
    final context = key?.currentContext;
    if (context != null) {
      _isManualScroll = true;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ).then(
        (_) => Future.delayed(const Duration(milliseconds: 500), () {
          _isManualScroll = false;
        }),
      );
    }
  }

  /// Converts a CustomPainter to an image (png bytes)
  Future<Uint8List> _captureDiagram(CustomPainter painter, double size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paintBounds = Rect.fromLTWH(0, 0, size, size);
    painter.paint(canvas, paintBounds.size);
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// Exports all diagrams to a single PDF file
  /// Exports all diagrams to a single PDF file (4 diagrams per page)
  Future<void> _exportToPDF(List<DiagramBundle> allBundles, double size) async {
    setState(() => _isExporting = true);

    final pdf = pw.Document();

    // Store all diagram images and titles
    final List<Map<String, dynamic>> diagramImages = [];

    for (final bundle in allBundles) {
      final title = bundle.diagramBundleEnum?.toText ?? 'Untitled Diagram';
      for (final painter in bundle.basePainterDiagrams) {
        final imageBytes = await _captureDiagram(painter, size);
        diagramImages.add({
          'title': title,
          'image': pw.MemoryImage(imageBytes),
        });
      }
    }

    // Group into pages of 4 diagrams
    const diagramsPerPage = 4;
    for (int i = 0; i < diagramImages.length; i += diagramsPerPage) {
      final group = diagramImages.skip(i).take(diagramsPerPage).toList();

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(24),
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              for (final item in group) ...[
                pw.Text(
                  item['title'] as String,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Image(
                  item['image'] as pw.ImageProvider,
                  width: size / 2.2,
                  height: size / 2.2,
                ),
                pw.SizedBox(height: 16),
                pw.Divider(),
              ],
            ],
          ),
        ),
      );
    }

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'All_Diagrams.pdf',
    );

    setState(() => _isExporting = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final homePageState = ref.watch(homePageProvider);
    final homePageNotifier = ref.watch(homePageProvider.notifier);

    final allBundles = AllDiagrams(
      size: size,
      colorScheme: colorScheme,
    ).getDiagramBundles(getAll: true);

    // Group by unit > subunit > diagram bundle
    final Map<UnitType, Map<Subunit, List<DiagramBundle>>> bundlesByUnit = {};
    for (var bundle in allBundles) {
      final enumValue = bundle.diagramBundleEnum;
      if (enumValue == null) continue;

      final unit = enumValue.unit;
      final subunit = enumValue.subunit;
      bundlesByUnit.putIfAbsent(unit, () => {});
      bundlesByUnit[unit]!.putIfAbsent(subunit, () => []);
      bundlesByUnit[unit]![subunit]!.add(bundle);

      // create unique id for each diagram
      final id = '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';
      _diagramKeys[id] ??= GlobalKey();
    }

    // ScrollSpy detection
    _scrollController.addListener(() {
      if (_isManualScroll) return;
      for (var entry in _diagramKeys.entries) {
        final box =
            entry.value.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          if (position < 200 && position > -200) {
            final id = entry.key;
            homePageNotifier.setSelectedDiagramId(id);
            break;
          }
        }
      }
    });

    // Sort units numerically
    final sortedUnits = bundlesByUnit.keys.toList()
      ..sort((a, b) {
        final aNum =
            double.tryParse(a.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        final bNum =
            double.tryParse(b.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        return aNum.compareTo(bNum);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Diagrams'),
        actions: [
          IconButton(
            icon: _isExporting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.picture_as_pdf),
            tooltip: 'Export all diagrams to PDF',
            onPressed: _isExporting
                ? null
                : () async {
                    await _exportToPDF(allBundles, size.width / 2.3);
                  },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- Sidebar ----------------
          Container(
            width: 350,
            color: Colors.grey[200],
            child: ListView(
              children: sortedUnits.map((unit) {
                final subunits = bundlesByUnit[unit]!;

                final sortedSubunits = subunits.keys.toList()
                  ..sort((a, b) {
                    final aNum =
                        double.tryParse(
                          a.id.replaceAll(RegExp(r'[^0-9.]'), ''),
                        ) ??
                        0;
                    final bNum =
                        double.tryParse(
                          b.id.replaceAll(RegExp(r'[^0-9.]'), ''),
                        ) ??
                        0;
                    return aNum.compareTo(bNum);
                  });

                return ExpansionTile(
                  title: Text(
                    '${unit.id} ${unit.title}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  children: sortedSubunits.map((subunit) {
                    final diagrams = subunits[subunit]!;

                    return ExpansionTile(
                      title: Text('${subunit.id} ${subunit.title}'),
                      initiallyExpanded: true,
                      children: diagrams.map((bundle) {
                        final id =
                            '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';
                        final isSelected =
                            homePageState.selectedDiagramId == id;

                        return ListTile(
                          dense: true,
                          title: Text(bundle.diagramBundleEnum?.toText ?? ''),
                          selected: isSelected,
                          selectedTileColor: Colors.blue.shade100,
                          onTap: () {
                            homePageNotifier.setSelectedDiagramId(id);
                            _scrollToDiagram(id);
                          },
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),

          // ---------------- Content Area ----------------
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sortedUnits.expand((unit) {
                    final subunits = bundlesByUnit[unit]!;

                    final sortedSubunits = subunits.keys.toList()
                      ..sort((a, b) {
                        final aNum =
                            double.tryParse(
                              a.id.replaceAll(RegExp(r'[^0-9.]'), ''),
                            ) ??
                            0;
                        final bNum =
                            double.tryParse(
                              b.id.replaceAll(RegExp(r'[^0-9.]'), ''),
                            ) ??
                            0;
                        return aNum.compareTo(bNum);
                      });

                    return sortedSubunits.expand((subunit) {
                      final bundles = subunits[subunit]!;

                      return bundles.map((bundle) {
                        final id =
                            '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';

                        return Container(
                          key: _diagramKeys[id],
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  bundle.diagramBundleEnum?.toText ??
                                      'Untitled Diagram',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                runSpacing: 16,
                                children: bundle.basePainterDiagrams
                                    .map(
                                      (d) => SizedBox(
                                        width: size.width / 2.3,
                                        height: size.width / 2.3,
                                        child: CustomPaint(painter: d),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        );
                      });
                    });
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
