import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../app/configs/constants.dart';
import '../enums/text_box_type.dart';

class CustomTextBox extends StatelessWidget {
  final String? term;
  final String text;
  final TextBoxType type;
  final bool isHL;

  const CustomTextBox({
    this.term,
    required this.text,
    required this.type,
    this.isHL = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = _getAccentColor(type);

    return Container(
      width: double.infinity,
      // ⬇️ Minimized vertical margin for tight stacking
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: const BoxDecoration(
        color: Colors.white, // ⚪ Pure white background
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📏 Subtle vertical accent line
            Container(width: 3, color: accentColor),
            Expanded(
              child: Padding(
                // ⬇️ Ultra-tight padding
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (term != null && term!.isNotEmpty) ...[
                      Text(
                        isHL
                            ? '${term!.toUpperCase()} [HL]'
                            : term!.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: accentColor,
                          height: 1.1, // ⬇️ Tighter line height for the label
                        ),
                      ),
                      // ⬇️ Smallest possible gap
                      const SizedBox(height: 1),
                    ],
                    HtmlWidget(
                      text,
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.2,
                      ),
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

  Color _getAccentColor(TextBoxType type) {
    switch (type) {
      case TextBoxType.term:
        return Colors.indigo.shade700;
      case TextBoxType.alert:
        return Colors.red.shade800;
      case TextBoxType.tip:
        return Colors.teal.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }
}
