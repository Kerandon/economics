import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../app/configs/constants.dart';
import '../enums/text_box_type.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    this.term,
    required this.text,
    required this.type,
    this.isHL = false, // flag for HL terms
    super.key,
  });

  final String? term; // nullable term
  final String text; // explanation or content
  final TextBoxType type;
  final bool isHL; // true if HL term

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Term color based on type
    Color termColor;
    switch (type) {
      case TextBoxType.term:
        termColor = Colors.deepOrange;
        break;
      case TextBoxType.alert:
        termColor = Colors.redAccent;
        break;
      case TextBoxType.tip:
        termColor = Colors.teal;
        break;
      case TextBoxType.content:
        termColor = theme.colorScheme.onSurface;
        break;
      case TextBoxType.keyContent:
        termColor = Colors.deepOrange;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet
          Text("• ", style: TextStyle(color: termColor, fontSize: 16)),
          // Term + text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (term != null)
                  Text(
                    isHL ? '$term (HL)' : term!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: termColor,
                    ),
                  ),
                HtmlWidget(
                  text,
                  textStyle: TextStyle(
                    color: theme.colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
