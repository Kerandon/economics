import 'package:flutter/material.dart';

class ParagraphBlock extends StatelessWidget {
  const ParagraphBlock(
    this.text, {
    this.isLarge,
    this.fontStyle,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  final String? text;
  final bool? isLarge;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textBlockPadding =
        EdgeInsets.symmetric(vertical: size.height * 0.020);
    final textTheme = Theme.of(context).textTheme;
    final textStyle = isLarge == true
        ? textTheme.bodyLarge
            ?.copyWith(fontStyle: fontStyle, fontWeight: fontWeight)
        : textTheme.bodyMedium
            ?.copyWith(fontStyle: fontStyle, fontWeight: fontWeight);

    return Padding(
      padding: textBlockPadding,
      child: text != null ? Text(text!, style: textStyle) : null,
    );
  }
}
