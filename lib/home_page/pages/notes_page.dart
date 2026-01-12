// Flutter imports
import 'package:economics_app/home_page/custom_widgets/diagram_gallery.dart';
import 'package:economics_app/home_page/pages/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/configs/constants.dart';
import '../custom_widgets/custom_text_box.dart';
import '../data/get_slides_by_key.dart';
import '../enums/text_box_type.dart';
import 'package:economics_app/home_page/enums/skill.dart';
import '../methods/pdf_service.dart';
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
  final GlobalKey _printKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final homePageState = ref.watch(homePageProvider);
    final slides = getSlides(
      size: size,
      theme: theme,
      key: homePageState.selectedSubunit,
    );

    for (var i = 0; i < slides.length; i++) {
      _sectionKeys.putIfAbsent(i, () => GlobalKey());
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => HybridPdfService.exportToPdf(
              fileName: 'Notes_${homePageState.selectedSubunit?.title}.pdf',
              slides: slides,
            ),
          ),
        ],
        title: Text(
          '${homePageState.selectedSubunit?.id} ${homePageState.selectedSubunit?.title}' ?? '',
        ),
      ),
      // RepaintBoundary remains outside to capture everything for PDF
      body: RepaintBoundary(
        key: _printKey,
        child: ListView(
          controller: _scrollController,
          // Scrollbar stays here (far right) because ListView is full width
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            // Center the content column within the full-width list
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                // Max width for readability (approx 60% of a large screen)
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ...slides.asMap().entries.map((entry) {
                        final index = entry.key;
                        final s = entry.value;

                        return Container(
                          key: _sectionKeys[index],
                          // Increased margin for better visual separation on web
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Header
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: HtmlWidget(
                                          '${s.title} ${s.hl ? kHLBrackets : ''}' ?? '',
                                          textStyle: theme.textTheme.displaySmall?.copyWith(
                                            color: colorScheme.onSurface,
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
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (s.contents?.isNotEmpty ?? false)
                                        ...s.contents!.map((c) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (c.term != null)
                                                  CustomTextBox(
                                                    term: c.term?.term ?? '',
                                                    text: c.term?.explanation ?? '',
                                                    type: TextBoxType.term,
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
                                                  ),
                                                if (c.content != null)
                                                  CustomTextBox(
                                                    text: c.content?.text ?? '',
                                                    type: TextBoxType.content,
                                                  ),
                                                if (c.widget != null) ...[c.widget!],
                                                if (c.diagramWidgets?.isNotEmpty ?? false) ...[
                                                  DiagramGallery(
                                                    diagrams: [...c.diagramWidgets!],
                                                  ),
                                                ],
                                              ],
                                            ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}