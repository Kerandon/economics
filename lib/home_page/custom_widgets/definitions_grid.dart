import 'package:flutter/material.dart';

import '../enums/text_box_type.dart';
import '../models/slide_content.dart';
import '../models/term.dart';
import 'custom_text_box.dart';

class GroupedDefinitionGrid extends StatelessWidget {
  final Map<String, List<SlideContent>> groupedItems;

  const GroupedDefinitionGrid({super.key, required this.groupedItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedItems.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Text(
                    entry.key.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(child: Divider()),
                ],
              ),
            ),
            // The Grid for this category
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: entry.value.map((item) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
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
          ],
        );
      }).toList(),
    );
  }
}
