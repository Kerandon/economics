import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../app/configs/app_colors.dart';
import '../../app/configs/constants.dart';
import '../enums/text_box_type.dart';
import '../models/term.dart';

class CustomTextBox extends StatelessWidget {
  final String? term;
  final String text;
  final TextBoxType type;
  final Tag? tag;

  const CustomTextBox({
    this.term,
    required this.text,
    required this.type,
    this.tag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    String tagLabel = '';
    final isHL = tag == Tag.hl;
    final isSupplement = tag == Tag.supplement;
    Color tagColor = colorScheme.primary;
    if(isHL){
      tagLabel = kHLBrackets;
      tagColor = AppColors.hLColor;
    }
    if(isSupplement){
      tagLabel = kSupplementBrackets;
      tagColor = AppColors.supplementColor;
    }


    return Container(
      width: double.infinity,
      // ⬇️ Minimized vertical margin for tight stacking
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration:  BoxDecoration(
        color: colorScheme.surface, // ⚪ Pure white background
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📏 Subtle vertical accent line
            Container(width: 3, color: colorScheme.primary),
            Expanded(
              child: Padding(
                // ⬇️ Ultra-tight padding
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (term != null && term!.isNotEmpty) ...[
                      Text(
                        '${term!.toUpperCase()} $tagLabel',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: tagColor,
                        )
                      ),
                      // ⬇️ Smallest possible gap
                      const SizedBox(height: 1),
                    ],
                    HtmlWidget(
                      text,
                      textStyle: theme.textTheme.bodyLarge
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
