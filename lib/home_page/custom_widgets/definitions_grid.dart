import 'package:flutter/material.dart';

import '../enums/text_box_type.dart';
import '../models/slide_content.dart';
import '../models/term.dart';
import 'custom_text_box.dart';

class GroupedDefinitionGridRedundant extends StatelessWidget {
  final Map<String, List<SlideContent>> groupedItems;

  const GroupedDefinitionGridRedundant({super.key, required this.groupedItems});

  @override
  Widget build(BuildContext context) {
    // Flatten the map since we only want one alphabetical list
    final allItems = groupedItems.values.expand((e) => e).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: allItems.map((item) {
          return SizedBox(
            // On mobile/small screens this allows 2 columns,
            // but is flexible enough for the PDF capture.
            width: (MediaQuery.of(context).size.width / 2) - 32,
            child: CustomTextBox(
              term: item.term?.term,
              text: item.term?.explanation ?? '',
              type: item.term?.tag == Tag.hl
                  ? TextBoxType.keyContent
                  : TextBoxType.term,
              isHL: item.term?.tag == Tag.hl,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DefinitionList extends StatelessWidget {
  final List<SlideContent> items;

  const DefinitionList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Tight vertical padding for a compact list
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Forces children to full width
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Spacing between rows
            child: CustomTextBox(
              term: item.term?.term,
              text: item.term?.explanation ?? '',
              type: item.term?.tag == Tag.hl
                  ? TextBoxType.keyContent
                  : TextBoxType.term,
              isHL: item.term?.tag == Tag.hl,
            ),
          );
        }).toList(),
      ),
    );
  }
}
