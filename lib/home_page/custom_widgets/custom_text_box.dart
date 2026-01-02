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
    final theme = Theme.of(context);

    Color accentColor;
    switch (type) {
      case TextBoxType.term:
        accentColor = Colors.indigo.shade400;
        break;
      case TextBoxType.alert:
        accentColor = Colors.redAccent;
        break;
      case TextBoxType.tip:
        accentColor = Colors.teal;
        break;
      default: // content or keyContent
        accentColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: accentColor,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (term != null)
              Text(
                isHL
                    ? '${term!.toUpperCase()} (HL)'
                    : term!.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.8,
                  color: accentColor,
                ),
              ),
            if (term != null) const SizedBox(height: 4),
            HtmlWidget(
              text,
              textStyle: const TextStyle(
                fontSize: 14,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
