import 'package:flutter/material.dart';

import '../../app/configs/app_colors.dart';
import '../enums/text_box_type.dart';
import '../models/slide_content.dart';
import '../models/term.dart';
import 'custom_text_box.dart';

int _tagPriority(Tag? tag) {
  if (tag == null || tag == Tag.none) return 0;
  if (tag == Tag.hl) return 1;
  if (tag == Tag.supplement) return 2;
  return 3;
}

String? _sectionTitleForTag(Tag? tag) {
  switch (tag) {
    case Tag.hl:
      return 'HL';
    case Tag.supplement:
      return 'Supplement';
    case null:
    case Tag.none:
      return null;
  }
}

Color? _sectionColorForTag(Tag? tag) {
  switch (tag) {
    case Tag.hl:
      return AppColors.hLColor;
    case Tag.supplement:
      return AppColors.supplementColor;
    default:
      return null; // Standard
  }
}

class DefinitionList extends StatelessWidget {
  final List<SlideContent> items;

  const DefinitionList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final sortedItems = [...items]
      ..sort((a, b) {
        final tagCompare = _tagPriority(
          a.term?.tag,
        ).compareTo(_tagPriority(b.term?.tag));
        if (tagCompare != 0) return tagCompare;

        return (a.term?.term ?? '').toLowerCase().compareTo(
          (b.term?.term ?? '').toLowerCase(),
        );
      });

    Tag? previousTag;
    Color? currentSectionColor;
    final children = <Widget>[];

    for (final item in sortedItems) {
      final currentTag = item.term?.tag;

      // Section boundary
      if (currentTag != previousTag) {
        currentSectionColor = _sectionColorForTag(currentTag);
        final title = _sectionTitleForTag(currentTag);

        if (title != null) {
          children.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: currentSectionColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }

        previousTag = currentTag;
      }

      final themedChild = currentSectionColor == null
          ? CustomTextBox(
              term: item.term?.term,
              text: item.term?.explanation ?? '',
              type: currentTag == Tag.hl
                  ? TextBoxType.keyContent
                  : TextBoxType.term,
              tag: null,
            )
          : Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: currentSectionColor!,
                  onSurface: currentSectionColor!,
                ),
                textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: currentSectionColor!,
                  displayColor: currentSectionColor!,
                ),
              ),
              child: CustomTextBox(
                term: item.term?.term,
                text: item.term?.explanation ?? '',
                type: currentTag == Tag.hl
                    ? TextBoxType.keyContent
                    : TextBoxType.term,
                tag: null,
              ),
            );

      children.add(
        Padding(padding: const EdgeInsets.only(bottom: 8), child: themedChild),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
