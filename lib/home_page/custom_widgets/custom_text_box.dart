import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../app/configs/constants.dart';
import '../enums/text_box_type.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({required this.text, required this.type, super.key});

  final String text;
  final TextBoxType type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    Color color = Colors.deepPurpleAccent;
    switch (type) {
      case TextBoxType.term:
        color = Colors.deepPurple;
      case TextBoxType.alert:
        color = Colors.red;
      case TextBoxType.tip:
        color = Colors.teal;
      case TextBoxType.content:
        color = theme.colorScheme.onSurface;
      case TextBoxType.keyContent:
        color = Colors.deepOrange;
    }

    final isContent = type == TextBoxType.content;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * kPageIndentVertical / 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius),
          border: isContent
              ? null
              : Border.all(
                  color: color, // Set your border color here
                  width: 2, // Optional: set border thickness
                ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: HtmlWidget(text, textStyle: TextStyle(color: color)),
      ),
    );
  }
}
