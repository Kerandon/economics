import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../methods/pdf_service.dart';
import '../data/get_slides_by_key.dart';
import '../state_management/home_page_state.dart';
import '../custom_widgets/diagram_gallery.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  final Map<int, List<Uint8List>> _diagramImages = {};
  bool _exporting = false;

  Future<void> _captureDiagrams(List<dynamic> slides) async {
    _diagramImages.clear();
    await WidgetsBinding.instance.endOfFrame;

    for (final slide in slides) {
      for (final content in slide.contents ?? []) {
        final widgets = content.diagramWidgets;
        if (widgets == null || widgets.isEmpty) continue;

        final images = <Uint8List>[];
        for (final dw in widgets) {
          final bytes = await DiagramCaptureService.captureFromKey(
            dw.repaintKey,
          );
          if (bytes.isNotEmpty) images.add(bytes);
        }

        if (images.isNotEmpty) {
          _diagramImages[content.hashCode] = images;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homePageProvider);
    final slides = getSlides(
      size: MediaQuery.of(context).size,
      theme: Theme.of(context),
      key: homeState.selectedSubunit,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(homeState.selectedSubunit?.title ?? ''),
        actions: [
          IconButton(
            icon: _exporting
                ? const CircularProgressIndicator(strokeWidth: 2)
                : const Icon(Icons.picture_as_pdf),
            onPressed: _exporting
                ? null
                : () async {
                    setState(() => _exporting = true);

                    await _captureDiagrams(slides);

                    await HybridPdfService.exportToPdf(
                      fileName: 'Notes_${homeState.selectedSubunit?.title}.pdf',
                      slides: slides,
                      diagramImages: _diagramImages,
                    );

                    setState(() => _exporting = false);
                  },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: slides.map((s) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    s.title ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children:
                        s.contents?.map((c) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (c.widget != null) c.widget!,
                              if (c.diagramWidgets?.isNotEmpty ?? false)
                                DiagramGallery(diagrams: c.diagramWidgets!),
                            ],
                          );
                        }).toList() ??
                        [],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DiagramCaptureService {
  /// Captures a widget wrapped in a RepaintBoundary using its GlobalKey.
  /// Returns an empty Uint8List if capture is not possible.
  static Future<Uint8List> captureFromKey(GlobalKey repaintKey) async {
    try {
      // Ensure at least one full frame has completed
      await WidgetsBinding.instance.endOfFrame;

      final context = repaintKey.currentContext;
      if (context == null) {
        debugPrint('DiagramCaptureService: context is null');
        return Uint8List(0);
      }

      final boundary = context.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        debugPrint('DiagramCaptureService: boundary is null');
        return Uint8List(0);
      }

      // If the widget still needs paint, wait one more frame
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 16));
        if (boundary.debugNeedsPaint) return Uint8List(0);
      }

      final ui.Image image = await boundary.toImage(
        pixelRatio: 3.0, // balance quality vs memory
      );

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return Uint8List(0);

      return byteData.buffer.asUint8List();
    } catch (e, stack) {
      debugPrint('Diagram capture error: $e');
      debugPrintStack(stackTrace: stack);
      return Uint8List(0);
    }
  }
}
