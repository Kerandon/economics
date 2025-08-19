import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../diagrams/diagram_widgets/diagram_bundle_widget.dart';
import '../custom_widgets/custom_text_box.dart';
import '../data/get_slides_by_key.dart';
import '../enums/text_box_type.dart';
import '../state_management/home_page_state.dart';

class NotesExpansionTilePage extends ConsumerWidget {
  const NotesExpansionTilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final homePageState = ref.watch(homePageProvider);
    final slides = getSlides(
      size: size,
      theme: theme,
      key: homePageState.selectedSubunit,
    );
    return Scaffold(
      appBar: AppBar(title: Text(homePageState.selectedSubunit?.title ?? '')),
      body: ListView(
        children: slides.map((s) {
          return Container(
            color: s.hl == true ? theme.primaryColorDark : theme.primaryColor,
            child: ExpansionTile(
              textColor: Colors.white,
              initiallyExpanded: true,
              title: HtmlWidget(
                '${s.title} ${s.hl == true ? '<strong>(HL)</strong>' : ''}',
              ),
              children: [
                Container(
                  color: theme.colorScheme.surface,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * kPageIndentHorizontal,
                          vertical: size.height * kPageIndentVertical,
                        ),
                        child: Column(
                          children: [
                            if (s.contents?.isNotEmpty ?? false)
                              ...s.contents!.map((c) {
                                return Column(
                                  children: [
                                    if (c.term != null)
                                      CustomTextBox(
                                        text:
                                            '<strong>${c.term?.term}</strong> ${c.term?.explanation}',
                                        type: TextBoxType.term,
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
                                        text:
                                            '<strong>${c.keyContent?.title}</strong> ${c.keyContent?.content}',
                                        type: TextBoxType.keyContent,
                                      ),
                                    if (c.content != null)
                                      CustomTextBox(
                                        text: c.content?.text ?? '',
                                        type: TextBoxType.content,
                                      ),

                                    if (c.diagramBundles?.isNotEmpty ?? false)
                                      Row(
                                        children: [
                                          ...c.diagramBundles!.map(
                                            (b) => DiagramBundleWidget(
                                              diagramBundle: b,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                );
                              }),
                          ],
                        ),
                      ),
                    ],
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
