// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../diagrams/diagram_widgets/diagram_bundle_widget.dart';
import '../custom_widgets/custom_text_box.dart';
import '../data/get_slides_by_key.dart';
import '../enums/text_box_type.dart';

import '../models/term.dart';
import '../state_management/home_page_state.dart'; // for rootBundle if needed
// SlideContent model

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final homePageState = ref.watch(homePageProvider);
    final slides = getSlides(
      size: size,
      theme: theme,
      key: homePageState.selectedSubunit,
    );

    // Assign keys for scroll-to-section
    for (var i = 0; i < slides.length; i++) {
      _sectionKeys.putIfAbsent(i, () => GlobalKey());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${homePageState.selectedSubunit?.id} ${homePageState.selectedSubunit?.title}' ??
              '',
        ),
        actions: [],
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          // TABLE OF CONTENTS
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contents",
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...slides.asMap().entries.map((entry) {
                    final index = entry.key;
                    final s = entry.value;
                    return GestureDetector(
                      onTap: () {
                        final keyContext = _sectionKeys[index]!.currentContext;
                        if (keyContext != null) {
                          Scrollable.ensureVisible(
                            keyContext,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 6,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                // ensure non-null string
                                (s.title ?? ''),
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            if (s.hl == true) _HLChip(),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // SECTIONS
          ...slides.asMap().entries.map((entry) {
            final index = entry.key;
            final s = entry.value;

            return Container(
              key: _sectionKeys[index],
              margin: const EdgeInsets.only(bottom: 20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: s.hl == true
                            ? theme.colorScheme.primary.withOpacity(0.85)
                            : theme.primaryColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: HtmlWidget(
                              // HtmlWidget expects a String; use empty string fallback
                              s.title ?? '',
                              textStyle: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (s.hl == true) _HLChip(color: Colors.white),
                        ],
                      ),
                    ),

                    // CONTENT
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (s.contents?.isNotEmpty ?? false)
                            ...s.contents!.map((c) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (c.term != null)
                                    CustomTextBox(
                                      term: c.term?.term ?? '',
                                      text: c.term?.explanation ?? '',
                                      type: TextBoxType.term,
                                      isHL: c.term?.tag == Tag.hl,
                                    ),

                                  if (c.alert != null)
                                    CustomTextBox(
                                      text: c.alert?.text ?? '',
                                      type: TextBoxType.alert,
                                    ),

                                  if (c.tip != null)
                                    CustomTextBox(
                                      text: c.tip?.text ?? '',
                                      type: TextBoxType.tip,
                                    ),

                                  if (c.keyContent != null)
                                    CustomTextBox(
                                      term: c.keyContent?.title ?? '',
                                      text: c.keyContent?.content ?? '',
                                      type: TextBoxType.keyContent,
                                      isHL: c.keyContent?.tag == Tag.hl,
                                    ),

                                  if (c.content != null)
                                    CustomTextBox(
                                      text: c.content?.text ?? '',
                                      type: TextBoxType.content,
                                    ),

                                  if (c.widget != null) c.widget!,

                                  // DIAGRAMS (robust null-safety + dynamic typing)
                                  if (c.diagramBundles?.isNotEmpty ?? false)
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final availableWidth =
                                            constraints.maxWidth;

                                        // Make diagrams bigger + smoother scaling
                                        final diagramWidth =
                                            (availableWidth * 0.65).clamp(
                                              150.0,
                                              400.0,
                                            );

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: c.diagramBundles!.map((
                                              diagram,
                                            ) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: diagramWidth,
                                                      height: diagramWidth,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child:
                                                            DiagramBundleWidget(
                                                              diagramBundle:
                                                                  diagram,
                                                            ),
                                                      ),
                                                    ),
                                                    if (diagram.title != null)
                                                      SizedBox(
                                                        width: diagramWidth,
                                                        child: Text(
                                                          diagram.title!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: theme
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// HL CHIP
class _HLChip extends StatelessWidget {
  final Color? color;
  const _HLChip({this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "HL",
        style: TextStyle(
          color: color != null ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// DIAGRAM SCROLLER - accepts a dynamic/object list and defends against nulls
class DiagramRow extends StatelessWidget {
  // Use List<Object?> to avoid referencing a missing DiagramBundle type
  final List<Object?> bundleList;
  const DiagramRow({required this.bundleList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (bundleList.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: bundleList.map((diagramObj) {
          if (diagramObj == null) return const SizedBox.shrink();

          // treat as dynamic to access properties (title, etc.)
          final dynamic diagram = diagramObj;

          // Safely get title (may be null)
          final String diagramTitle = (diagram.title as String?) ?? '';

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    // pass diagram to your DiagramBundleWidget.
                    // if DiagramBundleWidget expects a specific type, cast here:
                    // DiagramBundleWidget(diagramBundle: diagram as YourType)
                    child: DiagramBundleWidget(diagramBundle: diagram),
                  ),
                ),
                if (diagramTitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      diagramTitle,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
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
