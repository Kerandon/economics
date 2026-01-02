// Flutter imports
import 'package:economics_app/home_page/custom_widgets/diagram_gallery.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';
import 'package:economics_app/home_page/pages/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/configs/constants.dart';
import '../../diagrams/diagram_widgets/diagram_bundle_widget.dart';
import '../custom_widgets/custom_text_box.dart';
import '../data/get_slides_by_key.dart';
import '../enums/text_box_type.dart';
import 'package:economics_app/home_page/enums/skill.dart';

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
                            ? theme.colorScheme.secondary
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
                          if (s.hl == true) TagChip(label: kHL),
                          if (s.skills.isNotEmpty) ...[
                            ...s.skills.map((e) => TagChip(label: e.label)),
                          ],
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

                                  if (c.examples != null)
                                    CustomTextBox(
                                      text: c.examples?.text ?? '',
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

                                  if (c.widget != null) ...[c.widget!],
                                  if (c.diagramWidgets?.isNotEmpty ??
                                      false) ...[
                                    DiagramGallery(
                                      diagrams: [...c.diagramWidgets!],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     if (c.diagramWidgets?.isNotEmpty ??
                                    //         false) ...[
                                    //       ...c.diagramWidgets!.map((d) {
                                    //         final dim = size.width * 0.40;
                                    //         return CustomPaint(
                                    //           painter: d.basePainterDiagram,
                                    //           size: Size.square(dim),
                                    //         );
                                    //       }),
                                    //     ],
                                    //   ],
                                    // ),
                                  ],
                                ],
                              );
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
