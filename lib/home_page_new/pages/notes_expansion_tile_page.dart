import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../diagrams/data/all_diagrams.dart';
import '../../diagrams/diagram_widgets/diagram_bundle_widget.dart';
import '../../diagrams/enums/unit_type.dart';
import '../state_management/home_page_state.dart';

class NotesExpansionTilePage extends ConsumerWidget {
  const NotesExpansionTilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final homePageState = ref.watch(homePageProvider);
    final slides = getSlides(homePageState.selectedSubunit);
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ...slides.map(
                  (s) {
                final diagramBundles =
                AllDiagrams(size: size, colorScheme: theme.colorScheme)
                    .getDiagramBundles(
                    diagramBundleEnums: s.diagramBundleEnums);
                return ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero, // remove default padding so Container fills header
                  title: Container(
                    width: double.infinity, // make container full width
                    color: theme.colorScheme.primary, // background color
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // padding inside header
                    child: Text(
                      s.title ?? 'No title',
                      style: theme.primaryTextTheme.titleMedium, // ensure contrast text style
                    ),
                  ),
                  children: [
                    if (s.content?.isNotEmpty ?? false) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * kPageIndentHorizontal),
                        child: HtmlWidget(s.content ?? "No content"),
                      ),
                    ],
                    ...diagramBundles.map((b) => DiagramBundleWidget(diagramBundle: b)),
                  ],
                );

                  },
            )
          ],
        ));
  }
}
