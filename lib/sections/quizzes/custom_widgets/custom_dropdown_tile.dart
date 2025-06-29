
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class CustomDropdownTile extends StatelessWidget {
  const CustomDropdownTile({
    super.key,
    required this.text,
    this.isSelected,
    this.leading,
  });

  final String text;
  final bool? isSelected;
  final String? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ❌ Do NOT set fixed height here
      color: isSelected == true
          ? Theme.of(context).colorScheme.primary.withAlpha(155)
          : Colors.transparent,
      padding: const EdgeInsets.all(8.0), // move padding here for better layout
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          if (leading != null) ...[
            Expanded(
              flex: 1,
              child: Text(
                leading!,
                softWrap: true,
              ),
            ),
          ],
          Expanded(
            flex: 5,
            child: AutoSizeText(
              text,
              softWrap: true,
            ),
          ),
          if (isSelected != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                isSelected!
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
