import 'package:flutter/material.dart';

import '../../../../app/configs/constants.dart';

class DropdownContent extends StatelessWidget {
  const DropdownContent(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * kDropDownWidth, // Ensure max width is used
      child: Row(
        children: [
          Flexible(
            // Replace Expanded with Flexible
            child: Text(
              '  $text',
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
              softWrap: true, // Allow text to wrap
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(), // Optional: limit the number of lines
            ),
          ),
        ],
      ),
    );
  }
}
