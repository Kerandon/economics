import 'package:flutter/material.dart';

class CustomDropdownHeading extends StatelessWidget {
  const CustomDropdownHeading(
    this.text, {
    this.maxLines = 1,
    super.key,
  });

  final String text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              textAlign: TextAlign.left,
            ),
          ),
          const Icon(Icons.arrow_drop_down, size: 24),
        ],
      ),
    );
  }
}
