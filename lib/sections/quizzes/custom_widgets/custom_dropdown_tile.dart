import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomDropdownTile extends StatelessWidget {
  const CustomDropdownTile({
    super.key,
    required this.label,
    required this.selected,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 5, child: AutoSizeText(label, maxLines: 1,)),
        Expanded(
          child: IgnorePointer(
            child: Checkbox(
              value: selected,
              onChanged: (_) {},
            ),
          ),
        )
      ],
    );
  }
}
